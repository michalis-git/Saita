var db = null;

// Load score database
function loadDatabase()
{
    if (db)
        return;

    db = openDatabaseSync("Saita", "1.0", "Saita", 1000000);

    if (!db)
        return;

    var rs;
    db.transaction(function(tx) {
        tx.executeSql('CREATE TABLE IF NOT EXISTS scores(score INT, difficulty INT)');

        // get the local score for easy level
        var easyLocalScore = getLocalScore(0);
        if(easyLocalScore == -1)
            tx.executeSql('INSERT INTO scores(score,difficulty) VALUES(?,?)', [0,0]);

        // get the local score for medium level
        var mediumLocalScore = getLocalScore(1);
        if(mediumLocalScore == -1)
            tx.executeSql('INSERT INTO scores(score,difficulty) VALUES(?,?)', [0,1]);

        // get the local score for expert level
        var expertLocalScore = getLocalScore(2);
        if(expertLocalScore == -1)
            tx.executeSql('INSERT INTO scores(score,difficulty) VALUES(?,?)', [0,2]);
    });
}

// get the local score , the dif parameter is the difficulty level
function getLocalScore(dif){
    if (!db) {
        console.log("Warning: Database is not open");
        return 0;
    }

    var rs;
    db.transaction(function(tx) {
        rs = tx.executeSql('SELECT * FROM scores WHERE difficulty = ?',[dif]);
    });

    if (rs.rows.length > 0) {
        var record = rs.rows.item(0);
        return record.score;
    }else
        return -1;
}

// Update score database , the parameter val is the value to which the local score will be updated
function saveScoreToDisk(val)
{
    if (!db) {
        console.log("Warning: Database is not open");
        return false;
    }

    var localScore = getLocalScore(pageMain.difficultyLevel);

    // check if the localScore is less than the val
    if(localScore < val){
        db.transaction(function(tx) {
            tx.executeSql("UPDATE scores SET score = ? WHERE difficulty = ?", [Math.round(val),pageMain.difficultyLevel]);

            return true;
        });
    }
}