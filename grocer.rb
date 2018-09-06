def consolidate_cart(cart)
 newhash = Hash.new(0)
 cart.each do |hash|
   hash.each do |grocery, description|
     if !newhash.has_key? (grocery)
       newhash[grocery] = description
       newhash[grocery][:count] = 1
     else
       newhash[grocery][:count] += 1
     end
   end
 end
puts "consolidate cart", newhash
return newhash
end

def apply_coupons(cart, coupons)
  newCart = cart
  p "check coup", coupons
  coupons.each do |food|
    name = food[:item]
    if newCart.has_key?(name) && newCart[name][:count] >= food[:num]
      foodhash = {}
      foodhash[:clearance] = newCart[name][:clearance]
      foodhash[:price] = food[:cost]
      foodhash[:count] = newCart[name][:count] / food[:num]
      newCart[name][:count] = newCart[name][:count] % food[:num]
      newCart["#{name.to_s} W/COUPON"] = foodhash
    end
  end
return newCart
end

# def apply_coupons(cart, coupon)
#   coupon.each do |item|
#     name_of_item = item[:item]
#     if cart.has_key?(name_of_item) == true && cart[name_of_item][:count] >= item[:num]
#       cart[name_of_item][:count] = cart[name_of_item][:count] - item[:num]
#       new_item = name_of_item + (" W/COUPON")
#       puts cart.has_key?(new_item)
#       if cart.has_key?(new_item) == false
#         cart[new_item] = {:price => item[:cost], :clearance => cart[name_of_item][:clearance], :count => 1}
#       else 
#         cart[new_item][:count] += 1
#       end
#     end
#   end
#   return 
# end

def apply_clearance(cart)
  cart.each do |key, hash|
    if hash[:clearance]
      hash[:price] = (hash[:price] * 0.8).round(2)
    end
  end
return cart
end

def checkout(cart, coupons)
  finalCart = consolidate_cart(cart)
  discount = apply_coupons(finalCart, coupons)
  clear = apply_clearance(discount)
  total = 0
  
  clear.each do |key, hash|
    total += hash[:price] * hash[:count]
  end
  if total >= 100
    total = (total * 0.9).round(2)
  end
return total
end
