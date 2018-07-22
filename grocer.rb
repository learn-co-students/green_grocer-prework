def consolidate_cart(cart)
  consolidated_cart = {}
  cart.each do |food_hash|
    food_hash.each do |food_name, food_info|
      if consolidated_cart[food_name].nil?
        consolidated_cart[food_name] = food_info
        consolidated_cart[food_name][:count] = 1
      else
        consolidated_cart[food_name][:count] += 1
      end
    end
  end
  consolidated_cart
end

def apply_coupons(cart, coupons)
  coupon_cart = {}
  cart.each do |food_name, food_information|
    coupon_cart[food_name] = food_information
    coupons.each do |coupon|
      if food_name == coupon[:item] && food_information[:count] >= coupon[:num]
        coupon_cart["#{food_name} W/COUPON"] = {:price => coupon[:cost], :clearance => food_information[:clearance]}
        coupon_cart["#{food_name} W/COUPON"][:count] = coupon_cart[food_name][:count] / coupon[:num]
        coupon_cart[food_name][:count] = coupon_cart[food_name][:count] % coupon[:num]
      end
    end
  end
  coupon_cart
end

def apply_clearance(cart)
  cart.each do |food_name, food_information|
    if food_information[:clearance]
      food_information[:price] = (food_information[:price] * 0.80).round(2)
    end
  end
end

def checkout(cart, coupons)
  consolidated_cart = consolidate_cart(cart)
  couponed_cart = apply_coupons(consolidated_cart,coupons).delete_if {|food_name, food_info| food_info[:count] == 0}
  apply_clearance(couponed_cart)
  total = couponed_cart.collect {|food_name, food_information| food_information[:price]*food_information[:count]}.reduce(0.0) {|sum, price| sum + price}
  total = total.round(2)
  total = (total * 0.90).round(2) if total >= 100.0
  total
end
