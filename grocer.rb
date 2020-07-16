def consolidate_cart(cart)
  # code here
  consolidated_cart = {}
  cart.each do |cart_items|
    cart_items.each do |cart_item_name, cart_item|
      if !consolidated_cart.include?(cart_item_name)
        consolidated_cart[cart_item_name] = cart_item
        consolidated_cart[cart_item_name][:count] = 1;
      else
        consolidated_cart[cart_item_name][:count] += 1;
      end
    end
  end
  consolidated_cart
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    item_name = coupon[:item]
    if cart.include?(item_name)
      if cart[item_name][:count] >= coupon[:num]
        cart[item_name][:count] -= coupon[:num]
        coupon_item_name = "#{item_name} W/COUPON"
        if cart.include?(coupon_item_name)
          cart[coupon_item_name][:count] += 1
        else
          cart[coupon_item_name] = {price: coupon[:cost], clearance: cart[item_name][:clearance], count: 1}
        end
      end
      #if cart[item_name][:count] == 0
      #  cart.delete(item_name)
      #end
    end
  end
  cart
end

def apply_clearance(cart)
  cart.collect do |key, item|
    if item[:clearance]
      item[:price] = (item[:price] * ( 1.00 - 0.20)).round(1)
    end
    item
  end
  cart
end

def calculate_total(cart)
  total = 0.00
  cart.each do |key, item|
    total += item[:price] * item[:count]
  end
  total
end

def checkout(cart, coupons)
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)
  total = calculate_total(cart)
  if total > 100
    total = total * (1.00 - 0.10)
  end
  total
end
