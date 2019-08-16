require 'pry'

class VendingMachineRun 

  def run
    @allProducts = ["mars", "water", "kitkat", "nuts", "mars", "mars", "water"]
    @vendingMachineChange = [1,1,1,2,2,2,5,5,5,10,10,10,20,20,20,50,50,50,100,100,100,200,200,200]
    userORMaintainence
  end

  def userORMaintainence

      puts ("User or Maintaince? (u/m)")
      user = gets.chomp

      if user == "u"
        welcomemessage
      elsif user == "m"
        puts ("Do you want to restock vending Machine? (y/n)")
        restock = gets.chomp

        if restock == "y"
          puts ("What do you want to restock?")
            puts ("----------------------------")
            puts ("Options:")
            puts ("----------------------------")
            options = [ "products", "change"]
            puts options
            @restockSelected = gets.chomp
            restockingOptions
        elsif restock == "n"
          userORMaintainence
        else
          puts ("That is not an option. Please insert u or m.")
          puts ()
          puts userORMaintainence
        end

      else 
        puts ("That is not an option. Please insert u or m.")
        puts ()
        puts userORMaintainence
      end
  end

  def restockingOptions

    if @restockSelected == "products"
      puts ()
      puts("-------------------")
      puts ("Products restocked.")
      puts("-------------------")
      @allProducts = ["mars", "water", "kitkat", "nuts", "mars", "mars", "water"]
      itemsInVendingMachine
      userORMaintainence
    elsif @restockSelected == "change"

      puts "options: check or restock"
      checkOrRestock = gets.chomp

        if checkOrRestock == "check"
          changeArrays
          userORMaintainence
        elsif checkOrRestock == "restock"
            @vendingMachineChange = [1,1,1,1,2,2,5,5,5,5,10,10,10,20,20,20,50,50,50,100,100, 100,200,200]
            puts("-------------------")
            puts ("Change restocked")
            puts("-------------------")
            userORMaintainence
        else 
          puts ("That is not an option.")
          puts ()
          userORMaintainence
        end

    else 
      puts ("That is not an option.")
      puts ()
      userORMaintainence
    end
  end


  def changeArrays
        
    amounts = [1,2,5,10,20,50,100,200]

    changeArray = {}

    amounts.each do |amount|
      changeArray[amount] = @vendingMachineChange.select { |t| t == amount}
    end

    @onePence = changeArray[1]
    @twoPence = changeArray[2]
    @fivePence = changeArray[5]
    @tenPence = changeArray[10]
    @twentyPence = changeArray[20]
    @fiftyPence = changeArray[50]
    @onePound = changeArray[100]
    @twoPound = changeArray[200]

    puts ()
    puts "#{@sumOfProductsLeft} items left."
    puts ()

    changeAmounts = [@onePence, @twoPence, @fivePence, @tenPence, @twentyPence, @fiftyPence, @onePound, @twoPound ]
    
    changeAmounts.each do |amount|
      puts " There is #{amount.length}: #{amount[0]} pence left"
    end

    puts ()
  end


  def welcomemessage
    print "What is your name? "
    @name = gets.chomp
    puts("-------------------------------")
    puts("Hello #{@name}, please select an item...")
    puts("-------------------------------")
    settingStates
  end


  def settingStates

    @products = @allProducts.uniq
    @changeUniq = @vendingMachineChange.uniq
    @changeOptions = @vendingMachineChange.uniq
    @coinsInsert = []
    @userProducts=[]
    itemsInVendingMachine

    if @sumOfProductsLeft>0
      listOfProducts
    else 
      puts "Vending Machine empty!"
      puts ()
      puts("_______________________")
      userORMaintainence
    end
  end


  def itemsInVendingMachine
      
    items = ['mars', 'water', 'kitkat', 'nuts']
    selectedItemArray = {}

    items.each do |item|
      selectedItemArray[item] = @allProducts.select { |t| t == item}
    end

    @sumOfProductsLeft = (selectedItemArray['mars'].length)+(selectedItemArray['water'].length)+(selectedItemArray['kitkat'].length)+(selectedItemArray['nuts'].length)
    puts ()
    puts "#{@sumOfProductsLeft} items left."
    puts ()

    items.each do |item|
      itemName = selectedItemArray[item].length
      puts " There is #{itemName} #{item} left"
    end
    puts ()
  end


  def listOfProducts
    puts("Options:")
    puts("-------------------------------")
    puts @products
    puts("-------------------------------")
    selectitem
  end

  def selectitem

    items = ['mars', 'water', 'kitkat', 'nuts']

    allItems = {}

      items.each do |item|
        allItems[item] = (@allProducts.select { |t| t == item}.length)
      end

      puts()
      print "Please insert the name of the item you want..."
      @itemCheck = gets.chomp.downcase

      if items.include?(@itemCheck)

        if allItems[@itemCheck] > 0 
          @item = @itemCheck
        puts()
        puts("------------------------")
        puts("Selected item: #{@item}")
        priceDisplay
        else 
          puts ()
          puts ("There are no more #{@itemCheck} left, please select another item")
          listOfProducts
        end

    else 
      puts ()
      puts ("This Item does not exist, please select another item.")
      listOfProducts
    end
  end


  def priceDisplay

    puts()
    case @item
    when "mars"
      @price = 10
    when "water"
      @price = 200
    when "kitkat"
      @price = 50
    when "nuts"

      @price = 60
    else
      puts("This item does not exist, please enter another item.")
      puts("------------------------")
      selectitem
    end

    puts( "Price: #{@price}" )
    puts("------------------------")
    insertMoney
  end


  def insertMoney

      currentTotal = (@price.to_i)-(@total.to_i)

      puts("Please insert #{currentTotal} pence.")
      puts()
      puts("Select the coin inserted.")
      puts("------------------------")
      puts("Options:")
      puts("------------------------")
      puts @changeUniq
      puts("------------------------")
      currentTotal = 0 
      coinToBeChecked = (gets.chomp).to_i

    if [1, 2, 5, 10, 20, 50, 100, 200].include?(coinToBeChecked)
      @coin = coinToBeChecked
      @vendingMachineChange.push(@coin)
      validatedCoin
    else
      puts ()
      puts "Coin is not valid. Please insert correct coin."
      puts ()
      insertMoney
    end
  end


  def validatedCoin
      puts()
      puts ("You have inserted #{@coin} pence.")
      puts("_________________________________")
      @coinsInsert.push(@coin)
      @total = @coinsInsert.sum
      puts()
      puts ("Total input: #{@total} pence.")
      moreMoney
  end


  def changeGiven

    change = (@total)-(@price.to_i) 
    amounts = [ 50, 20, 10, 5, 2, 1]
    @customerChange= []

    @sumChange = @customerChange.inject(0, :+)

    if (change/100).to_f >= 1
      y = (change/100).to_i
      @customerChange.fill(100, @customerChange.size, y)
    end

      @sumChange = @customerChange.inject(0, :+)

    if @sumChange < change 

    amounts.each do |amount|

      @sumChange = @customerChange.inject(0, :+)

          if @sumChange < change 
            z = ((change-@sumChange)/amount).to_i
            @customerChange.fill(amount, @customerChange.size, z)
        
        end 
      end
    end
    removingChange
  end


  def moreMoney

      change = (@total)-(@price.to_i) 

    if change === 0 
      puts()
      puts("Perfect amount of money, Thanks!")
      puts()
      puts("Please take your item: #{@item}")
      puts("_________________________________")
      puts("Thanks #{@name}, enjoy your #{@item}!")
      puts("_________________________________")
      @allProducts.delete_at(@allProducts.index(@item))
      @userProducts.push(@item)
      
      anotherProduct
      
    elsif change<0
      puts()
      puts("Not enough money, please insert more coins")
      insertMoney
    else change>0
      puts()
      changeGiven
      puts("_________________________________")
      puts("Thanks #{@name}, enjoy your #{@item}!")
      puts("_________________________________")
      @allProducts.delete_at(@allProducts.index(@item))
      @userProducts.push(@item)
      anotherProduct
    end
  end


  def removingChange

    amounts = [200,100,50,20,10,5,2,1]
    changeArray = {}

    amounts.each do |amount|
      changeArray[amount] = ((@vendingMachineChange.select{|c| c == amount}).length) - ((@customerChange.select{|c| c == amount}).length)
    end

    change = (@total)-(@price.to_i) 
  
    if (changeArray[1]>0  && changeArray[2]>0  && changeArray[5]>0  && changeArray[10]>0  && changeArray[20]>0  && changeArray[50]>0  &&changeArray[100]>0  && changeArray[200]>0 )
    
      puts ("Please take your item: #{@item}")
      puts ("Change given: #{@customerChange} => #{change} Pence. ")

    loopTimes = @customerChange.length

    while loopTimes > 0
      x = @customerChange.shift
      @vendingMachineChange.delete_at(@vendingMachineChange.find_index(x))
      loopTimes-=1
    end

  else
    puts ("Sorry there is not enought change in this vending machine, please restock change.")
    puts ("----------------------------------")
    puts ("Change returned: #{@coinsInsert} ")
    puts ("----------------------------------")
    @total = 0 
      
    loopTimes1 = @coinsInsert.length
    
      while loopTimes1 > 0
        x = @coinsInsert.shift
        @vendingMachineChange.delete_at(@vendingMachineChange.find_index(x))
        loopTimes1-=1
      end

      userORMaintainence
    end
  end

  def anotherProduct

    @coinsInsert=[]
    @total=0

    puts("Would you like anything else? (y/n)")
    response = gets.chomp

    if response == "y"
      puts()
      puts("Please select another item.")
      @coinsInsert = []
      settingStates
    elsif response == "n"
      puts("___________________________")
      puts(" Have a nice day #{@name}! ")
      puts("___________________________")
      puts()
      puts("user items:")
      puts @userProducts
      puts("___________________________")
      puts()
      puts("Welcome!")
      puts()
      userORMaintainence
    else
      puts("please enter y or n.")
      anotherProduct
    end
  end
end