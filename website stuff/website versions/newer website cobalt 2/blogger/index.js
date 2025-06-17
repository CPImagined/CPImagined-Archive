import { readdirSync, readFileSync, writeFileSync, rmSync, existsSync, mkdirSync } from 'fs'
import { format, join } from "path"

export const formatUrl = (text) => {
    const allowed = (() => {
        const allowedStr = 'abcdefghijklmnopqrstuvwxyz1234567890-_'
        const c = []
        for(let i=0; i<allowedStr.length; i++) {
            c.push(allowedStr.charAt(i))
        }
        return c
    })()
    
    let st = ''
    for(let c in text) {
        const char = text.charAt(c)
        if(!allowed.find(a => a == char.toLowerCase())) {
            if(c == text.length -1 || c == 0) {
                continue
            }
            else {
                st = `${st}-`
                continue
            }
        }
        st = `${st}${char}`
    }
    return st.toLowerCase()
}
const newId = () => {
    return new Date().getTime() - 1680292406980 + (Math.floor(Math.random() * 1000)).toString()
}

export class BloggerError extends Error {
    constructor(message) {
        super(message);
        this.name = "BloggerError";
    }
}

export class BloggerObject {
    constructor(name, id = newId()) {
        this.name = name;
        this.url_name = formatUrl(name);
        this.id = id;
        this.saved = false;
        this._delete = false;
    }
    remove() {
        this._delete = true
    }
    edit(edits) {
        const ignore = ['saved', 'id', 'url_name']
        for (let e in edits) {
            if(ignore.find(i => i == e)) continue

            const edit = edits[e]
            if(edit !== undefined && edit !== '' && this[e]) {
                this[e] = edit
            }
        }
        this.url_name = formatUrl(this.name)
        this.edited = new Date()
    }
}

export class Author extends BloggerObject {
    constructor(name, bio, id) {
        super(name, id);
        this.bio = bio
    }
}

export class Post extends BloggerObject {
    constructor(name, date = new Date(), author, tags = [], body, description, id) {
        super(name, id);
        this.author = author;
        this.date = date;
        this.tags = tags;
        this.description = description;
        this.body = body;
        this.published = true;
        this.edited = null;
    }
}

export class Tag extends BloggerObject {
    constructor(name, description, colour = 'blue', id) {
        super(name, id);
        this.description = description;
        this.colour = colour
    }
}

export class BloggerTable {
    _content = [];
    childType

    constructor (childType, storageDir) {
        this.childType = childType
        this.storageDir = storageDir
    }

    get content() {
        // only provide posts that are not cached for deletion, AND remove fields like _delete and saved
        return this._content.filter(o => o._delete == false)
    }

    push(data) {
        if(!data instanceof this.childType) throw new BloggerError("Data does not match childType.")
        if (this._content.find(o => o.id == data.id)) { data.id = newId(); this._content.push(data) }
        else { this._content.push(data) }
        return this
    }

    _save() {
        const dir = `${this.childType.name.toLowerCase()}s`
        this._content.forEach(o => {
            // Clone the post then remove useless properties when saving
            const objectToSave = { ...o }
            delete objectToSave.saved
            delete objectToSave.url_name
            delete objectToSave._delete

            if (o._delete) {
                rmSync(join(this.storageDir, dir, o.id.toString()));
                this._content = this._content.filter(obj => obj.id !== o.id);
            }
            else {
                writeFileSync(join(this.storageDir, dir, o.id.toString()), JSON.stringify(objectToSave))
                o.saved = true
            }
        })
    }
}

export class PostsTable extends BloggerTable {
    constructor (storageDir) {
        super(Post, storageDir)
    }

    readFromJson(data) {
        const parsed = JSON.parse(data)

        let post = new Post(parsed.name, new Date(parsed.date), parsed.author, parsed.tags, parsed.body, parsed.description, parsed.id)
        post.edited = parsed.edited || undefined
        return post
    }

    addPost(data) {
        if(!data instanceof this.childType) throw new BloggerError("Data does not match childType.")
        if (!data.name || data.name == '') throw new BloggerError("Name cannot be empty.")
        if (this._content.find(p => p.url_name == data.url_name)) throw new BloggerError("Post name already exists.")
        this.push(data)
        return this
    }

    editPost(id, edits) {
        const post = this._content.find(p=> p.id == id)
        if(!post) return
        if (edits.name == '') throw new BloggerError("Name cannot be empty.");
        if(edits.name && this._content.find(p=>p.url_name == formatUrl(edits.name))) throw new BloggerError("Post name already exists.") 
        post.edit(edits)
    }

    _load() {
        const posts = readdirSync(join(this.storageDir, 'posts'))
        this._content = this._content.filter(p => p.saved == false)
        for (let file of posts) {
            this.push(this.readFromJson(readFileSync(join(this.storageDir, 'posts', file)).toString()))
        }
    }
}

export class TagsTable extends BloggerTable {
    constructor (storageDir) {
        super(Tag, storageDir)
    }

    readFromJson(data) {
        const parsed = JSON.parse(data)

        let tag = new Tag(parsed.name, parsed.description, parsed.colour, parsed.id)
        return tag
    }

    addTag(data) {
        if(!data instanceof this.childType) throw new BloggerError("Data does not match childType.")
        if (!data.name || data.name == '') throw new BloggerError("Name cannot be empty.")
        if (this._content.find(p => p.url_name == data.url_name)) throw new BloggerError("Post name already exists.")
        this.push(data)
        return this
    }

    editTag(id, edits) {
        const tag = this._content.find(t=> t.id == id)
        if (edits.name == '') throw new BloggerError("Name cannot be empty.");
        if(edits.name && this._content.find(t=>t.url_name == formatUrl(edits.name))) throw new BloggerError("Tag name already exists.") 
        tag.edit(edits)
    }

    _load() {
        const tags = readdirSync(join(this.storageDir, 'tags'))
        this._content = this._content.filter(t => t.saved == false)
        for (let file of tags) {
            this._content.push(this.readFromJson(readFileSync(join(this.storageDir, 'tags', file)).toString()))
        }
    }
}

export class AuthorsTable extends BloggerTable {
    constructor (storageDir) {
        super(Author, storageDir)
    }

    readFromJson(data) {
        const parsed = JSON.parse(data)

        let author = new Author(parsed.name, parsed.bio, parsed.id)
        return author
    }

    addAuthor(data) {
        if(!data instanceof this.childType) throw new BloggerError("Data does not match childType.")
        if (!data.name && data.name == '') throw new BloggerError("Name cannot be empty.")
        if (this._content.find(a => a.url_name == data.url_name)) throw new BloggerError("Author name already exists.")
        this.push(data)
        return this
    }

    editAuthor(id, edits) {
        const author = this._content.find(a=> a.id == id)
        if (edits.name == '') throw new BloggerError("Name cannot be empty.");
        if(edits.name && this._content.find(t=>t.url_name == formatUrl(edits.name))) throw new BloggerError("Author name already exists.") 
        author.edit(edits)
    }

    _load() {
        const authors = readdirSync(join(this.storageDir, 'authors'))
        this._content = this._content.filter(a => a.saved == false)
        for (let file of authors) {
            this._content.push(this.readFromJson(readFileSync(join(this.storageDir, 'authors', file)).toString()))
        }
    }
}

export class Blogger {
    posts;
    tags;
    authors;

    constructor(storageDir = './blog') {
        this.storageDir = storageDir;
        this.posts = new PostsTable(this.storageDir);
        this.tags = new TagsTable(this.storageDir);
        this.authors = new AuthorsTable(this.storageDir);

        this.load()
    }
    #checkDirectoryStructure() {
        if (!existsSync(join(this.storageDir, 'authors'))) { mkdirSync(join(this.storageDir, 'authors')) }
        if (!existsSync(join(this.storageDir, 'posts'))) { mkdirSync(join(this.storageDir, 'posts')) }
        if (!existsSync(join(this.storageDir, 'tags'))) { mkdirSync(join(this.storageDir, 'tags')) }
    }
    // Load the tables from storage
    load() {
        this.#checkDirectoryStructure()
        this.posts._load()
        this.tags._load()
        this.authors._load()

        return this
    }
    
    // Save the table to storage
    save() {
        this.#checkDirectoryStructure()
        this.posts._save()
        this.tags._save()
        this.authors._save()

        return this
    }
}

