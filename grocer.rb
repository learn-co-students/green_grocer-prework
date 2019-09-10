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
   end
  hash
  
end


def apply_coupons(cart, coupons)
    coupons.each do |coupon|
    item = coupon[:item]
    if cart[item] && cart[item][:count] >= coupon[:num] && !cart["#{item} W/COUPON"]
      cart["#{item} W/COUPON"] = {price: coupon[:cost] / coupon[:num] , clearance: cart[item][:clearance], count: coupon[:num]}
      cart[item][:count] -= coupon[:num]
      elsif cart[item] && cart[item][:count] >= coupon[:num] && cart["#{item} W/COUPON"]
      cart["#{item} W/COUPON"][:count] += coupon[:num]
       cart[item][:count] -= coupon[:num]
      end
    end
  cart
end 

def apply_clearance(cart)
  cart.each do |product_name, stats|
    stats[:price] -= stats[:price] * 0.2 if stats[:clearance]
   
  end 
  cart
end 





def checkout(array, coupons)
hash_cart = consolidate_cart(array)
applied_coupons = apply_coupons(hash_cart, coupons)
applied_discount = applied_clearance(applied_clearance)
total = applied_discount.reduce(0) { |acc, (key,value)| acc += value[:price] * value[:count] }
total > 100 ? total * 0.9 : total
end
