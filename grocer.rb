require "pry"

def consolidate_cart(cart)
  cart_with_counts = {}
  cart.each do |item|
    item.each do |item_name, info|
      if !cart_with_counts[item_name]
        cart_with_counts[item_name] = info
        cart_with_counts[item_name][:count] = 1
      else
        cart_with_counts[item_name][:count] += 1
      end
    end
  end
  cart_with_counts
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    item_name = coupon[:item]
    if cart[item_name] && cart[item_name][:count] >= coupon[:num]
      cart[item_name][:count] -= coupon[:num]
      if !cart[item_name + " W/COUPON"]
        cart[item_name + " W/COUPON"] = {:price => coupon[:cost], :clearance => cart[item_name][:clearance], :count => 1}
      else
        cart[item_name + " W/COUPON"][:count] += 1
      end
    end
  end
  # cart.delete_if {|item, info| info[:count] == 0}
  cart
end

def apply_clearance(cart)
  cart.each do |item, info|
    if info[:clearance]
      info[:price] = (info[:price] * 0.8).round(2)
    end
  end
end

def get_total_price(cart)
  total = 0
  cart.each do |item, info|
    total += info[:price] * info[:count]
  end
  total
end

def apply_large_discount(cart)

end

def checkout(cart, coupons)
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)
  total = get_total_price(cart)
  if total > 100
    total *= 0.9
  end
  total
end
