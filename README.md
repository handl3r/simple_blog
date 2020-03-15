# Tech
     rails 6.0.2.1
     mysql 5.7

---

# Database ver1.1

#### 1. User
    * email: string, uniqueness: { case_sensitive: false }
    * name: string, uniqueness: true, length: { minimum: 5, maximum: 20 }
    * password_digest:string, presence: true
    * remember_digest:string

#### 2. Post
    * user_id: integer
    * title: string, presence:true, length: {minimum:5}
    * body: text, presence:true
#### 3. Follow

    * followed_user_id: integer(user which be followed by another users)
    * follower_id: integer(user which give other user a follow)

#### 4. Comment
    * post_id: integer
    * user_id: integer
    * content: text, presence: true
#### 5. Admin
    * email: string, string, uniqueness: { case_sensitive: false }
    * name: string, uniqueness: true, length: { minimum: 5, maximum: 20 }
    * password_digest:string, presence: true
