# We use 'as' to give this build stage a name
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
# Because we dont want to change our source code we don't need volumes in this case and we just copy the entire source code
COPY . . 
RUN npm run build

FROM nginx
# We need to copy the build folder from 'builder stage' to '/usr/share/nginx/html' on the container, based on the nginx image document in Docker hub
COPY --from=builder /app/build /usr/share/nginx/html





