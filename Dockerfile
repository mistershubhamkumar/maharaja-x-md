FROM quay.io/lyfe00011/md:beta
RUN git clone https://github.com/Maharaja-x-md/Maharaja-x-md.git /root/Shubham-X-Md/
WORKDIR /root/Shubham-X-Md/
RUN yarn install
CMD ["npm", "start"]