def consolidate_cart(cart)
  # code here
  new_cart = {}
    cart.each do |food|
      food.each do |item, data|
        count = cart.count(food)
        data[:count] = count
        new_cart[item] ||= {}
        new_cart[item] = data
      end
    end
    new_cart
end

def apply_coupons(cart, coupons)
  # code here
  discount_cart = cart
  coupons.each do |coupon|
    item_name = coupon[:item]
    if discount_cart[item_name] && discount_cart[item_name][:count] >= coupon[:num]
      if discount_cart["#{item_name} W/COUPON"]
        discount_cart["#{item_name} W/COUPON"][:count] += 1
      else
        discount_cart["#{item_name} W/COUPON"] = {:count => 1, :price => coupon[:cost]}
        discount_cart["#{item_name} W/COUPON"][:clearance] = discount_cart[item_name][:clearance]
      end
      discount_cart[item_name][:count] -= coupon[:num]
    end
  end
  discount_cart
end

def apply_clearance(cart)
  # code here
  cart.each do |item, stats|
    if stats[:clearance] == true
      stats[:price] = (stats[:price] * 0.8).round(2)
    end
  end
end

def checkout(cart, coupons)
  # code here
  consolidated_cart = consolidate_cart(cart)
  discounted_cart = apply_coupons(consolidated_cart, coupons)
  final_cart = apply_clearance(discounted_cart)
  total = 0
    final_cart.each do |item, stats|
      total += stats[:price] * stats[:count]
    end
    total = total * 0.9 if total > 100
  total
end
