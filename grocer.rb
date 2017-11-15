def consolidate_cart(cart)
  hash = {}
  cart.each do |item|
    item.each do |key, value|
      if !(hash.keys.include?(key))
        hash[key] = value
        hash[key].merge!({count: 1})
      else
        value.each do |info,v2|
          if info == :count
            hash[key][:count] += 1
          end
        end
      end
    end
  end
  return hash
end

def apply_coupons(cart, coupons)
   coupons.each do |coupon|
     coupon_item = coupon[:item]
     if cart.keys.include?(coupon_item)
       num_items_in_cart = cart[coupon_item][:count]
       num_items_in_coupon = coupon[:num]
       if num_items_in_cart >= num_items_in_coupon
         cart["#{coupon_item} W/COUPON"] = {
           :price => coupon[:cost],
           :clearance => cart[coupon_item][:clearance], #true, always?
           :count => (num_items_in_cart/num_items_in_coupon).round
             }
         cart[coupon_item][:count] = (num_items_in_cart%num_items_in_coupon).round
       end
     end
   end
   cart
end

def apply_clearance(cart)
  cart.each do |item,info|
    #puts item ==>  ex AVOCADO
    #puts info ==>  ex {:price=>3.0, :clearance=>true, :count=>2}
    info.each do |key, value|
      #puts key ==> price, clearance, count
      #puts value ==> 3.0, true, 2
      if key == :clearance && value == true
        #puts "made it"
        #puts info[:price]
        discount = info[:price] * 0.2
        info[:price] -= discount
      end
    end
  end
  return cart
end

def checkout(cart, coupons)
  new_cart = consolidate_cart(cart)
  new_cart = apply_coupons(new_cart, coupons)
  new_cart = apply_clearance(new_cart)
  total = 0
  new_cart.each do |item, info|
    total += (info[:price] * info[:count])
  end
  if total > 100
    discount = total * 0.1
    total -= discount
  else
    total
  end
end
