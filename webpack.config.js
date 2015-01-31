module.exports = {
  entry :
    { application : __dirname + "/dynamic/app.js"
    }

, output :
    { path     : __dirname + "/public"
    , filename : "[name].js"
    }

, resolve :
    { modulesDirectories : ["node_modules"]
    }

, module :
    { loaders :
      [ { test    : /\.js$/
        , exclude : "node_modules"
        , loader  : "jsx-loader?harmony&stripTypes"
        }

      , { test    : /\.css$/
        , exclude : "node_modules"
        , loader  : "style-loader!css-loader!autoprefixer-loader!stylus-loader"
        }
    ]
  }
};
