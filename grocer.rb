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


def apply_coupons(cart, coupons)
    coupons.each do |coupon|
    item = coupon[:item]
    if cart[item] && coupon[:item][:count] >= coupon[:num] && !cart["#(item) W/COUPON"]
      cart["#(item) W/COUPON"] = {price: coupon[:cost] / coupon[:num] , clearance: cart[item][:clearance], count: coupon[:num]}
      cart[item][:count] -= coupon[:num]
      elsif coupon[:item][:count] >= coupon[:num] && !cart["#(item) W/COUPON"]
      cart["#(item) W/COUPON"][:count] += coupon[:num]
      end
    end
  cart
end 

def apply_clearance(cart)

end 





def checkout(cart, coupons)
end
