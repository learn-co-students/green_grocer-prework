require'pry'
def consolidate_cart(cart)
  hash = {}
   cart.each do |item_hash|
    item_hash.each do |name, price_hash|
     if hash[name] 
        hash[name][:count] +=1
     else
       hash[name] = price_hash
       hash[name][:count] = 1
       end 
     end

      hash[name][:count] = 1
  item_hash = {}
  cart.each do |item_hash|
    item_hash.each do |item_hash|
 if item_hash == name

      end 
  
    end
  end 
  hash
  
end
end

def apply_coupons(cart)
end 

def apply_clearance(cart)
  
end





def checkout(cart, coupons)
end
