def consolidate_cart(cart)
  new_cart = {}

  cart.uniq.each do |item|
    new_cart.merge!(item)
    new_cart[item.keys[0]][:count] = cart.count(item)
  end

  new_cart
end

def apply_coupons(cart, coupons)
  new_cart = {}
  coupon_match = {}

  cart.each do |item, item_info|
    # detect coupon if it exists
    coupon_match = coupons.detect { |coupon| coupon[:item] == item }

    if !coupon_match.nil?
      coupon_item = coupon_match[:item]
      coupon_num = coupon_match[:num]
      coupon_cost = coupon_match[:cost]

      if item_info[:count] >= coupon_num
        new_cart[item] = {}
        new_cart[item][:price] = item_info[:price]
        new_cart[item][:clearance] = item_info[:clearance]
        new_cart[item][:count] = item_info[:count] % coupon_num
        new_cart[item + " W/COUPON"] = {}
        new_cart[item + " W/COUPON"][:price] = coupon_cost
        new_cart[item + " W/COUPON"][:clearance] = item_info[:clearance]
        new_cart[item + " W/COUPON"][:count] = item_info[:count] / coupon_num
      # elsif (item_info[:count] % coupon_num) == 0 #no regularly-priced items added
      #   new_cart[item + " W/COUPON"] = {}
      #   new_cart[item + " W/COUPON"][:price] = coupon_cost
      #   new_cart[item + " W/COUPON"][:clearance] = item_info[:clearance]
      #   new_cart[item + " W/COUPON"][:count] = item_info[:count] - (item_info[:count] % coupon_num)
      else #not enough items so coupon doesn't apply, add without coupon
        new_cart[item] = {}
        new_cart[item][:price] = item_info[:price]
        new_cart[item][:clearance] = item_info[:clearance]
        new_cart[item][:count] = item_info[:count]
      end
    else #add item without coupon
      new_cart[item] = {}
      new_cart[item][:price] = item_info[:price]
      new_cart[item][:clearance] = item_info[:clearance]
      new_cart[item][:count] = item_info[:count]
    end
  end

  new_cart
end

def apply_clearance(cart)
  new_cart = {}

  cart.each do |item, item_info|
    new_cart[item] = {}
    new_cart[item][:clearance] = item_info[:clearance]
    new_cart[item][:count] = item_info[:count]
    if item_info[:clearance]
      new_cart[item][:price] = (item_info[:price] * 0.8).round(1)
    else
      new_cart[item][:price] = item_info[:price]
    end
  end

  new_cart
end

def checkout(cart, coupons)
  new_cart = {}
  total = 0.00

  # Apply coupon discounts if the proper number of items are present.
  new_cart = apply_coupons(consolidate_cart(cart), coupons)
  # Apply 20% discount if items are on clearance.
  new_cart = apply_clearance(new_cart)

  #total the cart
  new_cart.each do |item, item_info|
    total += (item_info[:price] * item_info[:count])
  end

  # If, after applying the coupon discounts and the clearance discounts, the cart's total is over $100, then apply a 10% discount.
  if total > 100
    total = (total * 0.90).round(2)
  end

  total
end
