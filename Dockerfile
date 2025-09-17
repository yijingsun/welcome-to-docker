# Start your image with a node base image
FROM node:22-alpine

# The /app directory should act as the main application directory
WORKDIR /app

# Copy the app package and package-lock.json file
COPY package*.json ./

# Copy local directories to the current local directory of our docker image (/app)
COPY ./src ./src
COPY ./public ./public

# Install node packages, install serve, build the app, and remove dependencies at the end
# check the CA expiration date if you have issues with npm install
RUN npm config set registry https://registry.npmmirror.com/\
    && npm install \
    && npm install -g serve@latest \
    && npm run build \
    && rm -fr node_modules

EXPOSE 3000

# Start the app using serve command
CMD [ "serve", "-s", "build" ]