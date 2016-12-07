# PYGMY

## Routes

### REST Example
```
GET    /posts     - Retrieves a list of post
GET    /posts/12  - Retrieves a specific post
POST   /posts     - Creates a new post
PUT    /posts/12  - Updates post #12
PATCH  /posts/12  - Partially updates post #12
DELETE /posts/12  - Deletes post #12
```

### Page Routes
```
GET /                  - Home Page (lists posts)
GET /login
GET /register
GET /:username         - Show user profile
GET /users/:id/edit - Shows form for editing an account
```

### Action Routes
```
POST   /login             - Log user in
GET    /logout            - Log user out
POST   /users             - Store user in DB
POST   /posts             - Store post in DB
DELETE /posts/:id         - Delete post :id
PUT    /posts/:id         - Update post :id
POST   /users/:id/follow  - Current user follows user :id
DELETE /users/:id/follow  - Current user unfollows user :id
DELETE /users/:id      - Deletes account :id
```
