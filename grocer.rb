require "pry" 

def consolidate_cart(cart)
  # code here
  cart_hash = {}
  cart.each do |cart_item|
    cart_item.each do |name, data|
      if cart_hash[name]
        cart_hash[name][:count] += 1
      else
        cart_hash[name] = data
        cart_hash[name][:count] = 1
      end
    end
  end
  cart_hash
end 
 
def apply_coupons(cart, coupons)
  coupons.each do |coupon|
  item_key = coupon[:item]
  if cart.has_key?(item_key) && cart[item_key][:count] >= coupon[:num]
     num_coupons = cart[item_key][:count]/coupon[:num]
     cart["#{item_key} W/COUPON"] = {:price => coupon[:cost], :clearance => cart[item_key][:clearance], :count => num_coupons}
     cart[item_key][:count] = cart[item_key][:count] % coupon[:num]
   end
 end
 cart 
 end
 
def apply_clearance(cart)
   cart.each do |item, details|
     if details[:clearance]
       discount = details[:price] * 0.20
       details[:price] = details[:price] - discount 
     end
   end
 end 
   
def checkout(cart, coupons)
  total = 0
  updated_cart = consolidate_cart(cart)
  if updated_cart.length >= 1
    coupons_applied = apply_coupons(updated_cart, coupons)
    clearance_applied = apply_clearance(coupons_applied)
    clearance_applied.each do |item, details|
      total += details[:price] * details[:count]
      if total >= 100
      total = total - (total * 0.10)
    end 
  end 
end 
return total 
end 

