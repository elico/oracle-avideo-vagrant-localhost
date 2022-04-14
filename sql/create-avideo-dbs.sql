CREATE DATABASE AVideo CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
create user AVideo@localhost identified by 'your-password';
grant all privileges on AVideo.* to AVideo@localhost;
CREATE DATABASE AVideoEncoder CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
create user AVideoEncoder@localhost identified by 'your-password';
grant all privileges on AVideoEncoder.* to AVideoEncoder@localhost;
flush privileges;
