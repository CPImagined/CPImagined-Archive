import {Auther, Token} from './auther/index.js'

const auther = new Auther('./tokens')
const token = new Token({lifetime: 30 * 60 * 1000})
console.log(token.token)
console.log("This token will expire in 30 minutes.")
auther.push(token)