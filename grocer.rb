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

#def apply_cupons(cart, cupons)
 #cupons.each do |coupon_hash|
  
  
#end
#end 













































































































































































































































































=======
>>>>>>> c2a30ffd2df3f9499a5cd481024634ad904d8a81
def apply_coupons(cart, coupons)
  
end





def apply_clearance(cart)
  
end





def checkout(cart, coupons)
end
