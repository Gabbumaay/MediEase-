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
    origin: function(origin, callback) {
        if (!origin || [allowedOrigin, 'https://medi-ease-client.vercel.app'].indexOf(origin) !== -1) {
            callback(null, true);
        } else {
            callback(new Error('Not allowed by CORS'));
        }
    },
    allowedHeaders: ['Content-Type', 'Authorization'],
    credentials: true
}));

module.exports = app;
