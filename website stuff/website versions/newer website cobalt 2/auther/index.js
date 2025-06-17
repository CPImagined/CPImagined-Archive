import crypto from 'crypto'
import { readFileSync, writeFileSync, existsSync } from 'fs'

export class AutherError extends Error {
    constructor(message) {
        super(message);
        this.name = "AutherError";
    }
}

export class Token {
    constructor(options = { lifetime: undefined, length: undefined, expires: undefined, token: undefined, }) {
        const {lifetime, length = 64, expires, token} = options;
        
        if(!lifetime && !expires) throw new AutherError("No lifetime specified.")
        if(lifetime && expires) console.warn("Both `lifetime` and `expires` received. `expires` will be ignored.")

        // If lifetime is specified, use it to create an expiry time, otherwise pass the expiry time provided : for reading from file
        this.expires = lifetime ? new Date().getTime() + lifetime : expires,
        // If a token is not specified, generate a new one, otherwise pass the given one : for reading from file
        this.token = !token ? crypto.randomBytes(length).toString("base64url") : token
    }   

    get expired() {
        return this.expires < new Date().getTime() 
    }

}

export class Auther {
    #tokens;
    constructor(tokensPath = './tokens', tokenLength = 64) {
        this.tokensPath = tokensPath,
        this.tokenLength = tokenLength;
        this.#tokens = [];

        this._load();
    }

    push(t) {
        this.#tokens.push(t)
        this._save()
        return t
    }

    get tokens() {
        this._load()
        return this.#tokens
    }

    isAuthed(token) {
        this._load()
        if(!this.#tokens.find(t => t.token == token)) return false
        else if(this.#tokens.find(t => t.token == token && !t.expired)) return true
        return false
    }

    _load() {
        if(!existsSync(this.tokensPath)) return this._save()
        else {
            const tokens = JSON.parse(readFileSync(this.tokensPath))
            this.#tokens = tokens.map(t => {
                const { token, expires } = t
                return new Token({ token, expires })
            })
        }
    }
    _save() {
        this.#tokens = this.#tokens.filter(t => t.expires > new Date().getTime())
        writeFileSync(this.tokensPath,JSON.stringify(this.#tokens))
    }
}