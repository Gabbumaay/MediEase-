const express = require("express");
const cors = require("cors");
const cookieParser = require("cookie-parser");
const allowedOrigin = process.env.CLIENT_URL || "http://localhost:5173";
const app = express();

app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(express.static("public"));
app.use(cookieParser());

//TODO: Change the origin to deployed frontend URL
app.use(cors({
    origin: allowedOrigin,
    credentials: true
}));

module.exports = app;
