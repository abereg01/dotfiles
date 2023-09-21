function hi --wraps=notify-send\ \'Hi\ there!\'\ \'Welcome\ to\ my\ desktop!\ \'\ -i\ \'\' --description alias\ hi=notify-send\ \'Hi\ there!\'\ \'Welcome\ to\ my\ desktop!\ \'\ -i\ \'\'
  notify-send 'Hi there!' 'Welcome to my desktop! ' -i '' $argv
        
end
