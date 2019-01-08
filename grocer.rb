require "pry"
def consolidate_cart(cart)
  my_con_cart = {}
  cart.each do |each__food_hash|
    each__food_hash.each do |food_str, info_hash|
      if (my_con_cart == nil) || !(my_con_cart.keys.include?(food_str))
        my_con_cart[food_str] = info_hash
        my_con_cart[food_str][:count] = 1
      elsif my_con_cart.keys.include?(food_str)
        my_con_cart[food_str][:count] += 1
      end
    end
  end

  my_con_cart
end

def apply_coupons(cart, coupons)
  # binding.pry
  coupons.each do |coupon_el|
    coup_food = coupon_el[:item]
        if cart.keys.include?(coup_food) && coupon_el[:num] <= cart[coup_food][:count]
          if cart.keys.include?("#{coup_food} W/COUPON")
            cart["#{coup_food} W/COUPON"][:count] += 1
            cart[coup_food][:count] = cart[coup_food][:count] - coupon_el[:num]
          else
            cart["#{coup_food} W/COUPON"] = {
              :price => coupon_el[:cost],
              :clearance => cart[coup_food][:clearance],
              :count => 1
            }
            cart[coup_food][:count] = cart[coup_food][:count] - coupon_el[:num]
          end
        else
        cart
        end
      end
  cart
end

def apply_clearance(cart)
  cart.each do |food, food_hash|
    if food_hash[:clearance] == true
      clearance_price = food_hash[:price] - (food_hash[:price] * 0.2)
      food_hash[:price] = clearance_price
    end
  end
  cart
end

def checkout(cart, coupons)
  total = 0
  # binding.pry

  consolidate_cart = consolidate_cart(cart)
  coupons_cart = apply_coupons(consolidate_cart, coupons)
  final_cart = apply_clearance(coupons_cart)

  final_cart.each do |food, food_hash|
    total += food_hash[:price] * food_hash[:count]

  end
  if total > 100
    new_total = total - (total * 0.1)
    return new_total
  end
  total
end
