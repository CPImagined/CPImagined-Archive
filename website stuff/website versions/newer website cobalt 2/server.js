import express, { json } from "express";
import { readFileSync, readdirSync, lstatSync, existsSync } from "fs";
import { format, join } from "path";
import crypto from "crypto";

const app = express()

import * as url from 'url'
const __dirname = url.fileURLToPath(new URL('.', import.meta.url));

const port = readFileSync(join(__dirname, 'port')).toString() || 8080;
const publicPath = join(__dirname, 'public')
const srcPath = join(__dirname, 'src')
import { Blogger, Post, Tag, Author, formatUrl } from "./blogger/index.js";
import { Auther, Token } from './auther/index.js'

app.use(((req, res, next) => {
    res.set('Access-Control-Allow-Origin', 'http://localhost:*')
    res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Authorization, Content-Type, Accept");
    next()
}))
// RouteSafe converts the given path to a path with forward slashes, allowing it to be seamlessly used in an express route
const routeSafe = (path) => {
    return path.replace(/\\/g, "/");
}
// Read the provided directory and its contents
const readDir = (queryPath) => {
    const relativeQueryDir = queryPath.replace(publicPath, '')
    for(const child of readdirSync(queryPath)) {
        // Format some useful path variations of the child
        const fullPath = join(queryPath, child)
        const relativePublicPath = fullPath.replace(publicPath, '')
        const fileStat = lstatSync(fullPath)
        
        if(fileStat.isDirectory()) {
            // The child is a directory, read it
            readDir(fullPath)
        }
        else {
            // The child is a file
            // If the file is an index.html, set the route to the parent directory
            if(child.toLowerCase() == 'index.html') {
                app.get(routeSafe(relativeQueryDir), (req, res) => {
                    res.sendFile(fullPath)
                })
            }
            else {
                // Otherwise, serve the file as normal, with its relative path, with and without html
                if(relativePublicPath.endsWith('.html')) {
                    app.get([routeSafe(relativePublicPath), routeSafe(relativePublicPath).replace('.html','')], (req, res) => {
                        res.sendFile(fullPath)
                    })
                }
                app.get([routeSafe(relativePublicPath)], (req, res) => {
                    res.sendFile(fullPath)
                })
            }
            
        }
    }
}
readDir(publicPath)


const blogger = new Blogger('./blog')
const auther = new Auther('./tokens')

for (let post of blogger.posts.content.filter(p => p.published == true)) {
    let url = `whats-new/${post.url_name}`
    console.log(`http://localhost:${port}/${url}`)
    app.get(`/${url}`, (req,res) => {
        return res.sendFile(join(srcPath, 'blogpost.html'))
    })
}
for (let tag of blogger.tags.content) {
    let url = `whats-new/topics/${tag.url_name}`
    console.log(`http://localhost:${port}/${url}`)
    app.get(`/${url}`, (req,res) => {
        return res.sendFile(join(srcPath, 'topic.html'))
    })
}

const getToken = (req) => {
    if(!req.headers.authorization) return undefined
    return req.headers.authorization.split(' ')[1]
}

app.use(json())
app.get(`/whats-new/`, (req,res) => {
    return res.sendFile(join(srcPath, 'bloglanding.html'))
})
app.get(`/whats-new/topics`, (req,res) => {
    return res.sendFile(join(srcPath, 'topicslanding.html'))
})

app.get('/api', (req,res) => {
    return res.send("cpimagined.net api")
})
app.get('/api/blog', (req,res) => {
    const help = `
        <strong>GET /api/blog/posts/</strong>
        ?tag=id
        get an array of post ids

        <strong>GET /api/blog/tags/</strong>
        get an array of tag ids

        <strong>GET /api/blog/post</strong>
        ?name=url_name
        ?id=id
        get post by id

        <strong>GET /api/blog/tag</strong>
        ?name=url_name
        ?id=id
        get tag by id

    `.split("\n").join("</br>")
    return res.send(`<strong>cpimagined.net blog api 1.0</strong><br>${help}`)
})


app.get('/api/blog/posts', (req,res) => {
    const query = req.query
    
    const filteredPosts = (() => {
        if(auther.isAuthed(getToken(req))) {
            return blogger.posts.content
        }
        else {
            return blogger.posts.content.filter(p => p.published == true)
        }
    })()    
    

    const response = {}
    
    if(query.tag) {
        const tagId = query.tag
        const filtered = filteredPosts.filter(p => p.tags.indexOf(tagId) > -1)
        
        response.content = filtered
    }
    else if(query.author) {
        const author = decodeURI(query.author)
        const filtered = filteredPosts.filter(p => p.author == author)
        
        response.content = filtered  
    }
    else {
        response.content = filteredPosts
    }
    
    res.send(JSON.stringify(response))

})
app.get('/api/blog/tags', (req,res) => {
    res.contentType('application/json')
    const response = { content: blogger.tags.content }
    res.send(response)
})
app.get('/api/blog/authors', (req,res) => {
    res.contentType('application/json')
    const response = { content: blogger.authors.content }
    res.send(response)
})
app.get('/api/blog/post', (req,res) => {
    const query = req.query
    res.contentType('application/json')
    const filteredPosts = (() => {
        if(auther.isAuthed(getToken(req))) {
            return blogger.posts.content
        }
        else {
            return blogger.posts.content.filter(p => p.published == true)
        }
    })()    
    
    const post  =(() => {
        if(query.id) return filteredPosts.find(p => p.id == query.id)
        else if(query.name) return filteredPosts.find(p => p.url_name == query.name)
    })()
    
    if(!post) return res.sendStatus(404)
    const response = { content: post }
    res.send(response)
})
app.get('/api/blog/tag', (req,res) => {
    const query = req.query
    res.contentType('application/json')

    const tag  = (() => {
        if(query.id) return blogger.tags.content.find(t => t.id == query.id)
        else if(query.name) {
            return blogger.tags.content.find(t => t.url_name == query.name)
        }
    })()
    
    if(!tag) return res.sendStatus(404)
    const response = { content: tag }
    return res.send(response)
})
app.get('/api/blog/author', (req,res) => {
    const query = req.query
    res.contentType('application/json')

    const author  = (() => {
        if(query.id) return blogger.authors.content.find(a => a.id == query.id)
        else if(query.name) {
            return blogger.authors.content.find(a => a.id == query.id)
        }
    })()
    
    if(!author) return res.sendStatus(404)
    const response = { content: author }
    return res.send(response)
})



app.post('/api/blog/post/new', (req, res) => {
    if(!auther.isAuthed(getToken(req))) return res.sendStatus(401)

    const { name, author, date, topics, description, body } = req.body
    if(!(name || author || date || topics || description || body)) return res.sendStatus(400)
    if(blogger.posts.content.find(p => p.url_name == formatUrl(name))) return res.sendStatus(403)

    blogger.posts.addPost(new Post(name, date, author, topics, body, description))
    blogger.save()

    return res.sendStatus(201);
})
app.patch('/api/blog/post/edit', (req, res) => {
    if(!auther.isAuthed(getToken(req))) return res.sendStatus(401)
    if(!blogger.posts.content.find(p => p.id == req.body.id)) return res.sendStatus(404)
    const { id } = req.body
    if(!id) return res.sendStatus(400)

    blogger.posts.editPost(id, req.body)
    blogger.save()
    
    return res.sendStatus(200);
})
app.delete('/api/blog/post/delete', (req, res) => {
    if(!auther.isAuthed(getToken(req))) return res.sendStatus(401)
    
    const {id} = req.query

    if(!id) return res.sendStatus(400)

    const post = blogger.posts.content.find(p => p.id == id)
    if(!post) return res.sendStatus(404)

    post.remove()
    blogger.save()

    return res.sendStatus(200)
})

app.post('/api/blog/tag/new', (req, res) => {
    if(!auther.isAuthed(getToken(req))) return res.sendStatus(401)

    const { name, description, colour } = req.body
    if(!(name || description || colour)) return res.sendStatus(400)
    if(blogger.tags.content.find(t => t.url_name == formatUrl(name))) return res.sendStatus(403)

    blogger.tags.addTag(new Tag(name, description, colour))
    blogger.save()

    return res.sendStatus(201);
})
app.patch('/api/blog/tag/edit', (req, res) => {
    if(!auther.isAuthed(getToken(req))) return res.sendStatus(401)
    if(!blogger.tags.content.find(t => t.id == req.body.id)) return res.sendStatus(404)
    const { id } = req.body
    if(!id) return res.sendStatus(400)

    blogger.tags.editTag(id, req.body)
    blogger.save()
    
    return res.sendStatus(200);
})
app.delete('/api/blog/tag/delete', (req, res) => {
    if(!auther.isAuthed(getToken(req))) return res.sendStatus(401)
    
    const {id} = req.query

    if(!id) return res.sendStatus(400)

    const tag = blogger.tags.content.find(t => t.id == id)
    if(!tag) return res.sendStatus(404)

    tag.remove()
    blogger.save()

    return res.sendStatus(200)
})

app.post('/api/blog/author/new', (req, res) => {
    if(!auther.isAuthed(getToken(req))) return res.sendStatus(401)

    const { name, bio } = req.body
    if(!(name || bio)) return res.sendStatus(400)
    if(blogger.authors.content.find(a => a.url_name == formatUrl(name))) return res.sendStatus(403)

    blogger.authors.addAuthor(new Author(name, bio))
    blogger.save()

    return res.sendStatus(201);
})
app.patch('/api/blog/author/edit', (req, res) => {
    if(!auther.isAuthed(getToken(req))) return res.sendStatus(401)
    if(!blogger.authors.content.find(a => a.id == req.body.id)) return res.sendStatus(404)
    const { id } = req.body
    if(!id) return res.sendStatus(400)

    blogger.authors.editAuthor(id, req.body)
    blogger.save()
    
    return res.sendStatus(200);
})

app.delete('/api/blog/author/delete', (req, res) => {
    if(!auther.isAuthed(getToken(req))) return res.sendStatus(401)
    
    const {id} = req.query

    if(!id) return res.sendStatus(400)
    console.log(blogger.authors.content)
    const author = blogger.authors.content.find(a => a.id == id)
    
    if(!author) return res.sendStatus(404)

    author.remove()
    blogger.save()

    return res.sendStatus(200)
})


app.get('/404', (req, res) => {
    return res.sendFile(join(srcPath, '404.html'))
})

app.get('*', (req, res) => {
    return res.sendFile(join(srcPath, '404.html'))
})

app.listen(port, () => {
    console.log(`cobalt running on port ${port}`)
})