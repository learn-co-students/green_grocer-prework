require "pry"

def consolidate_cart(cart)
  consolidated_cart = {}
  cart.each_with_object({}) do |item, consolidated_cart|
    item.each do |item_name, item_info|
      if consolidated_cart[item_name]
        item_info[:count] += 1
      else
        item_info[:count] = 1
        consolidated_cart[item_name] = item_info
      end
    end
  end
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    item_name = coupon[:item]

    if cart.keys.include?(item_name) && cart[item_name][:count] >= coupon[:num]
      # check if cart already has a coupon for the same item
      if cart["#{item_name} W/COUPON"]
        cart["#{item_name} W/COUPON"][:count] += 1
      else
        cart["#{item_name} W/COUPON"] = {}
        # add coupon price
        cart["#{item_name} W/COUPON"][:price] = coupon[:cost]
        # set coupon number equal to 1 for first coupon
        cart["#{item_name} W/COUPON"][:count] = 1
        # remember if item was on clearance
        cart["#{item_name} W/COUPON"][:clearance] = cart[item_name][:clearance]
      end

      # removes discounted items from original item's count
      cart[item_name][:count] -= coupon[:num]
    end
  end
  cart
end

def apply_clearance(cart)
  cart.each do |item_name, item_info|
    if item_info[:clearance] == true
      item_info[:price] -= item_info[:price] * 0.2
    end
  end
  cart
end

def checkout(cart, coupons)

  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)

  # calculate total price
  total_price = 0
  cart.each do |item_name, item_info|
    total_price += item_info[:price] * item_info[:count]
  end

  total_price -= total_price * 0.1 if total_price > 100

  total_price
end
