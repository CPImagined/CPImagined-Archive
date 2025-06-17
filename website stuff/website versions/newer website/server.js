const e = require('express')
const express = require('express')
const app = express()

const port = 8080

const fs = require('fs')
const { platform } = require('os')
const path = require('path')

const publicDir = path.join(__dirname, 'public')
var filesList = [];
var blogHome;

function getPostElement(title, author, authorid, description, category, categoryimg, postimg, color, rgbcolor, textimg, date, file) {
    return `
    <a href="whats-new/${file}">
      <div class="postcont">
        <div class="post" style="border-color:${color};">
          <div class="posttextimg" style="background-image: url(../images/${textimg}.png);"></div>
          <div class="postimg" style="border-color:${color};background-image:url(whats-new/images/${postimg}.png);">
            <div class="postimggrad" style="background-image: linear-gradient(rgba(${rgbcolor}, 0), rgba(${rgbcolor}, 0), rgba(${rgbcolor}, 0.7));">
              <div class="postauthimg" style="border-color:${color};background-image:url(https://play.cpimagined.net/avatar/${authorid}/cp?size=120&photo=true)"></div>
              <div class="posttitle">
                ${title}
              </div>
              <div class="postauth">
                ${author}
              </div>
            </div>
          </div>
          <div class="posttext">
            ${description}
          </div>
          <div class="postdate" style="background-color:${color};">
            ${date}
          </div>
          <div class="postcategory" style="color:${color};">
            <img src="whats-new/images/Category${categoryimg}.png" width="90%"><br>
            ${category}
          </div>
        </div>
      </div>
    </a>
    `
}

function getLink(href, alias) {
    return `<a class="awhite" href="${href}">${alias}</a>`
}

let months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sept',
    'Oct',
    'Nov',
    'Dec'
]
function loadBlog() {
    //YY MM DD
    var blog = fs.readFileSync(`${publicDir}/whats-new/whats-new.html`).toString()
    var postsList = [];
    let postsDir = fs.readdirSync(`${publicDir}/whats-new/posts`)
    for (let folder of postsDir) {
        if (folder == 'latest') { continue }
        const data = JSON.parse(fs.readFileSync(`${publicDir}/whats-new/posts/${folder}/data.json`));
        var date = data.date.split('-')
        var month = months[parseInt(date[1]) - 1]
        var day = date[2]
        var year = date[0]
        var dateString = `${month} ${day} ${year}`

        postsList.push([data.date, getPostElement(data.title, data.author, data.authorid, data.description, data.category, data.categoryimg, data.postimg, data.color, data.rgbcolor, data.textimg, dateString, folder), folder])
        postsList.sort((a, b) => {
            return new Date(b[0]) - new Date(a[0])
        });

        app.get(`/whats-new/${folder}`, (req, res) => {
            res.sendFile(`${publicDir}/whats-new/posts/${folder}/post.html`)
        })

    }
    let posts = postsList.map(post => post[1])

    // Always redirect /whats-new/latest to the latest post
    let latestPostFolder = postsList.map(post => post[2])[0].toString();
    app.get('/whats-new/latest', (req, res) => {
        res.redirect(`/whats-new/${latestPostFolder}`)
    });

    blog = blog.replace('{POSTS}', posts.join('\n'))
    blogHome = blog;
}

// ROUTES



const ignore = fs.readFileSync(path.join(publicDir, '.ignore')).toString().split('\n')
function includesIgnore(str, dir = false) {
    if (dir) {
        for (let i in ignore) {
            if (`${str}/`.includes(ignore[i])) {
                return true;
            }
        }
    }
    else {
        for (let i in ignore) {
            if (str.includes(ignore[i])) {
                return true;
            }
        }
    }
    return false;
}

function serveFiles() {
    function readDir(dir) {
        let dirFiles = fs.readdirSync(dir)
        let safePath = dir.replace(`${publicDir}`, '')
        for (let file of dirFiles) {
            let relativePath = path.join(safePath, file).replace(/\\/g, '/')
            if (fs.lstatSync(path.join(dir, file)).isDirectory()) {
                if (includesIgnore(file, true)) {
                    continue;
                }
                readDir(path.join(dir, file))
                continue;
            }
            else {
                if (includesIgnore(file) || file == '.ignore') {
                    continue;
                }
            }

            // Safe path is the path that will be used in the route, and relativepath is the exact path of the item relative to the public directory.
            // Safe path removes .html for cleaner routes, but relative path still needs this to serve the associated file.
            let safeFilePath = relativePath;
            if (safeFilePath.endsWith('.html')) {
                safeFilePath = safeFilePath.replace('.html', '')
            }
            if (safeFilePath.startsWith('/')) {
                safeFilePath = safeFilePath.substring(1)
            }
            app.get(`/${safeFilePath}`, (req, res) => {
                res.sendFile(`${publicDir}/${relativePath}`)
            })
        }
    }
    readDir(publicDir);
}

function getFilesList() {
    let filesPath = fs.readdirSync(path.join(`${publicDir}`, 'files'))

    for (let file of filesPath) {
        filesList.push(file);
    }
}

// ROOT
app.get(`/`, (req, res) => {
    res.sendFile(`${publicDir}/index.html`)
})

// AUTO ROUTING 
serveFiles();
getFilesList();

// STORAGE.HTML INDEX
app.get("/storage", (req, res) => {
    const generatedHtml = (() => {
        var s = '';
        for (let file of filesList) {
            s = `${s}${getLink(path.join('files', file), file)}`
        }
        return s
    })()
    return res.send(fs.readFileSync(path.join(publicDir, 'storage.html')).toString().replace("{FILES}", generatedHtml))
})

// BLOG ROUTES
loadBlog();
app.get(`/whats-new`, (req, res) => {
    res.send(blogHome);
})

// 404 ROUTE
app.get('*', function (req, res) {
    res.send(fs.readFileSync(`${publicDir}/404.html`).toString().replace('{URL}', req.url))
});

app.listen(port, () => {
    console.log(`cpimagined.net listening on port ${port}.`)
})