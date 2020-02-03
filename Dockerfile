#Building the multi-use Docker file
#Creating the base image and tagging that as a builder. The same build can be used to copy to the production environment with out the dependencies being installed once again
FROM node:alpine as builder 

#Docker file written by

MAINTAINER Suresh

#Creating the work directory

WORKDIR /app

#Copying the package.json from the present directory

COPY package.json .

#Rnnning the npm server

RUN npm install

#Copying the complete files to Work directory

COPY . .

#Starting the devlopment build

RUN npm run build

#Creating the Docker file for the Production environment

FROM ngnix

#Copying the work from the builder image
#/app/build is the directory where all the build files will be stored.
#/usr/share/ngnix/html is the folder where ngnix will use the data.
COPY --from=builder /app/build /usr/share/ngnix/html
