require "pry"

def consolidate_cart(cart)
  hash_cart = {}
  cart.each do |array|
    array.each do |item, details|
      details1 = details.update(:count => cart.count(array))
      hash_cart[item] = details1
    end
  end
hash_cart
end

def apply_coupons(cart, coupons)
c_item = ""
  coupons.each do |array|
        c_item = array[:item]
        if cart.has_key?(c_item)
          if cart[c_item][:count] >= array[:num]

          cart["#{c_item} W/COUPON"] = {
            :price => array[:cost],
            :clearance => cart[c_item][:clearance],
            :count => cart[c_item][:count].to_i/array[:num].to_i}

            cart[c_item][:count] = cart[c_item][:count].to_i%array[:num].to_i
          end
      end
    end
cart
end

def apply_clearance(cart)
new_price = 0.00
  cart.each do |item, attributes|
    if cart[item][:clearance] == true
      new_price = cart[item][:price] * 0.8
      cart[item][:price] = new_price.round(2)
    end
  end
  cart
end

def checkout(cart, coupons)
  cart_1= consolidate_cart(cart)
  cart_1_ac =  apply_coupons(cart_1, coupons)
  cart_1_acc = apply_clearance(cart_1_ac)
  cart_total = 0.00
  cart_1_acc.each do |item, attributes|
    cart_total += cart_1_acc[item][:price]*cart_1_acc[item][:count]
  end
  if cart_total > 100
    cart_total *= 0.90
  end
  cart_total
end
