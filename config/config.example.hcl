_boot {
    exec = <<SQL
        CREATE TABLE IF NOT EXISTS `users` (
            `ID` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
            `name` VARCHAR(30) DEFAULT "@anonymous",
            `email` VARCHAR(30) DEFAULT "@anonymous",
            `password` VARCHAR(200) DEFAULT "",
            `time` INT UNSIGNED
        );
    SQL
}
allusers {
    methods = ["GET"]
    exec = <<SQL
        SELECT * FROM users;
    SQL
}
adduser {
    methods = ["POST"]
    rules {
        user_name = ["required"]
        user_email =  ["required", "email"]
        user_password = ["required", "stringlength: 5,50"]
    }
    exec = <<SQL
        {{ template "_boot" }}

        /* let's bind a vars to be used within our internal prepared statment */
        {{ .BindVar "name" .Input.user_name }}
        {{ .BindVar "email" .Input.user_email }}
        {{ .BindVar "emailx" .Input.user_email }}

        INSERT INTO users(name, email, password, time) VALUES(
            /* we added it above */
            :name,

            /* we added it above */
            :email,

            /* it will be secured anyway because it is encoded */
            '{{ .Input.user_password | .Hash "bcrypt" }}',

            /* generate a unix timestamp "seconds" */
            {{ .UnixTime }}
        );

        SELECT * FROM users WHERE id = LAST_INSERT_ID();
    SQL
}
databases {
    exec = "SHOW DATABASES"

    transformer = <<JS
        // there is a global variable called `$result`,
        // `$result` holds the result of the sql execution.
        (function(){
            newResult = []

            for ( i in $result ) {
                newResult.push($result[i].Database)
            }

            return newResult
        })()
    JS
}
usersinfo {
  exec = "select * from users"
  transformer = <<JS
    // do some convert only print name && email
    (function(){
       var newResult=[];
       for (var item in $result) {
        var user = {
            user_name:$result[item].name,
            user_email:$result[item].email
        }
        newResult.push(user)
       }
       return newResult; 
    })()
  JS

}