require 'pry'

def consolidate_cart(cart)
  # code here
  new_hash = {}

  cart.each do |item_hash|
    item_hash.each do |item_name, item_info|
      if new_hash[item_name] == nil
        item_info[:count] = 1
        new_hash[item_name] = item_info
      else
        new_hash[item_name][:count] += 1
      end

    end
  end

  new_hash

end

def apply_coupons(cart, coupons)
  # code here
  new_hash = {}

    cart.each do |item_name, item_info|

      new_hash[item_name] = item_info

      coupons.each do |coupon|
        if item_name == coupon[:item]
          if item_info[:count] >= coupon[:num]
            item_info[:count] -= coupon[:num]

            if new_hash.include?(item_name+" W/COUPON")
              new_hash[item_name+" W/COUPON"][:count] += 1
            else
              new_hash[item_name+" W/COUPON"] = {
                  :price => coupon[:cost],
                  :clearance => item_info[:clearance],
                  :count => 1
             }
            end
          end

        end

    end


  end

new_hash
end

def apply_clearance(cart)

  new_hash = {}

  cart.each do |cart_item, cart_info|
    if cart_info[:clearance]
      cart_info[:price] = (cart_info[:price] * 0.8).round(2)
    end
    new_hash[cart_item] = cart_info
  end

  new_hash
end

def checkout(cart, coupons)
  total = 0.00

  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)

  cart.each do |food_item, food_info|
    total += (food_info[:price] * food_info[:count]) unless food_info[:count] == 0
  end

  if total > 100
    total *= 0.9 
  end

  total

end
