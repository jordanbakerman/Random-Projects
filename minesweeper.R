
#############
# Minesweeper
#############

# Create a Minesweeper Grid
nr = nc = 9
mines = 10
cells = nr*nc
mymat = matrix(0,nr,nc)

set.seed(802)
mines.locs = sample(1:(nr*nc),size=mines,replace=FALSE)
bomb.symbol = -1
mymat[mines.locs] = bomb.symbol
mymat

mymat = cbind(mymat,0); mymat = cbind(0,mymat); mymat = rbind(mymat,0); mymat = rbind(0,mymat)
mymat

locs = NULL
counts = NULL

#Middle
for(i in 2:(nr+1)){
  for(j in 2:(nc+1)){
    
    locs = rbind(locs,c(i,j))
    if(mymat[i,j]!=bomb.symbol){
      
      count = mymat[i-1,j-1]+mymat[i-1,j]+mymat[i-1,j+1]+
        mymat[i,j-1]+mymat[i,j+1]+
        mymat[i+1,j-1]+mymat[i+1,j]+mymat[i+1,j+1]
      count = abs(count)
      
    } else{
      count = bomb.symbol
    }
    
    counts = c(counts,count)
    
  }
}

mymat[locs] = counts
mymat = mymat[,-1]; mymat = mymat[,-(nc+1)]; mymat = mymat[-1,]; mymat = mymat[-(nr+1),]
mymat

plot(0:10,0:10,type="n")
row.func = (nr:1)
for(i in 1:nr){
  for(j in 1:nc){
    
    mylab = mymat[i,j]
    if(mylab==bomb.symbol){
      text(j,row.func[i],label="B",col="black")
    } else if(mylab==0){
      text(j,row.func[i],label=mylab,col="yellow")
    } else if(mylab==1){
      text(j,row.func[i],label=mylab,col="blue")
    } else if(mylab==2){
      text(j,row.func[i],label=mylab,col="green")
    } else if(mylab==3){
      text(j,row.func[i],label=mylab,col="red")
    } else if(mylab==4){
      text(j,row.func[i],label=mylab,col="purple")
    } else if(mylab==5){
      text(j,row.func[i],label=mylab,col="maroon")
    } else if(mylab==6){
      text(j,row.func[i],label=mylab,col="turquoise")
    } else if(mylab==7){
      text(j,row.func[i],label=mylab,col="black")
    } else if(mylab==8){
      text(j,row.func[i],label=mylab,col="grey")
    }
    
  }
}

##############################################
# Create Minesweeper Function to Play the Game
##############################################

# Function to take in user input
vals = function(){
  newval1 = as.numeric(readline(prompt = "   ROW POSITION   "))
  newval2 = as.numeric(readline(prompt = "   COL POSITION   "))
  newvals = c(as.numeric(newval1),as.numeric(newval2))
  return(newvals)
}

# Game Function
minesweeper = function(myseed, nr, nc, mines){
  
  set.seed(myseed)
  cells = nr*nc
  mymat = matrix(0,nr,nc)
  
  mines.locs = sample(1:(nr*nc),size=mines,replace=FALSE)
  bomb.symbol = -1
  mymat[mines.locs] = bomb.symbol
  
  mymat = cbind(mymat,0); mymat = cbind(0,mymat); mymat = rbind(mymat,0); mymat = rbind(0,mymat)
  
  locs = NULL
  counts = NULL
  
  #Middle
  for(i in 2:(nr+1)){
    for(j in 2:(nc+1)){
      
      locs = rbind(locs,c(i,j))
      if(mymat[i,j]!=bomb.symbol){
        
        count = mymat[i-1,j-1]+mymat[i-1,j]+mymat[i-1,j+1]+
          mymat[i,j-1]+mymat[i,j+1]+
          mymat[i+1,j-1]+mymat[i+1,j]+mymat[i+1,j+1]
        count = abs(count)
        
      } else{
        count = bomb.symbol
      }
      
      counts = c(counts,count)
      
    }
  }
  
  mymat[locs] = counts
  mymat = mymat[,-1]; mymat = mymat[,-(nc+1)]; mymat = mymat[-1,]; mymat = mymat[-(nr+1),]
  
  #Initialize
  plot(0:10,0:10,type="n")
  row.func = (nr:1)
  mymat.observed = matrix(0,nr,nc)
  
  newvals = vals()
  i = newvals[1]
  j = newvals[2]
  mylab = mymat[i,j]
  if(mylab==bomb.symbol){
    text(j,row.func[i],label="B",col="black")
  } else if(mylab==0){
    text(j,row.func[i],label=mylab,col="yellow")
  } else if(mylab==1){
    text(j,row.func[i],label=mylab,col="blue")
  } else if(mylab==2){
    text(j,row.func[i],label=mylab,col="green")
  } else if(mylab==3){
    text(j,row.func[i],label=mylab,col="red")
  } else if(mylab==4){
    text(j,row.func[i],label=mylab,col="purple")
  } else if(mylab==5){
    text(j,row.func[i],label=mylab,col="maroon")
  } else if(mylab==6){
    text(j,row.func[i],label=mylab,col="turquoise")
  } else if(mylab==7){
    text(j,row.func[i],label=mylab,col="black")
  } else if(mylab==8){
    text(j,row.func[i],label=mylab,col="grey")
  }
  
  if(mymat[i,j]==bomb.symbol){print("BOOOOOM")}
  
  #REPEAT THIS PART
  while(mymat[i,j]!=bomb.symbol){
    
    newvals = vals()
    
    i = newvals[1]
    j = newvals[2]
    mylab = mymat[i,j]
    if(mylab==bomb.symbol){
      text(j,row.func[i],label="B",col="black")
    } else if(mylab==0){
      text(j,row.func[i],label=mylab,col="yellow")
    } else if(mylab==1){
      text(j,row.func[i],label=mylab,col="blue")
    } else if(mylab==2){
      text(j,row.func[i],label=mylab,col="green")
    } else if(mylab==3){
      text(j,row.func[i],label=mylab,col="red")
    } else if(mylab==4){
      text(j,row.func[i],label=mylab,col="purple")
    } else if(mylab==5){
      text(j,row.func[i],label=mylab,col="maroon")
    } else if(mylab==6){
      text(j,row.func[i],label=mylab,col="turquoise")
    } else if(mylab==7){
      text(j,row.func[i],label=mylab,col="black")
    } else if(mylab==8){
      text(j,row.func[i],label=mylab,col="grey")
    }
    
    if(mymat[i,j]==bomb.symbol){
      
      print("BOOOOOM")
      
    }
    
  } #While
  
  for(i in 1:nr){
    for(j in 1:nc){
      
      mylab = mymat[i,j]
      if(mylab==bomb.symbol){
        text(j,row.func[i],label="B",col="black")
      } 
      
    }
  }
  
}

# Play Minesweeper
minesweeper(myseed=802, nr=9, nc=9, mines=10)


