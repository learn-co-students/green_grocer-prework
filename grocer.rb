def consolidate_cart(cart)
  #add count to keys
  new_cart = {}
  #add counter to info hash and then add item pair to new cart
  cart.each do |hash|
    hash.each do |item, info_h|
      if new_cart.key?(item)
        new_cart[item][:count] += 1
      else
        info_h[:count] = 1
        new_cart[item] = info_h
      end
    end
  end
  new_cart
end

def apply_coupons(cart, coupons)
  new_cart = {}
  cart.each do |k,v|
    new_cart[k] = v
  end
  #initialize hash of counters for coupons per item
  coupon_counter = {}
  coupons.each do |coupon|
    key = coupon[:item]
    coupon_counter[key] = 1
  end
  #iterate over array of coupons
  coupons.each do |coupon|
    #if the item is in the cart calculate discount
    if cart.keys.include?(coupon[:item])
      #create variables for item names
      item = coupon[:item]
      item_w_coupon = item + " W/COUPON"
      #create variables for non-coupon values
      item_count = new_cart[item][:count]
      item_price = new_cart[item][:price]
      item_clear = new_cart[item][:clearance]
      #create variables for coupon values
      sale_count = coupon[:num]
      sale_price = coupon[:cost]
      remaining_items = item_count - sale_count
      #track number of coupons for current item
      coupon_count = coupon_counter[item]
      #add adjusted items to new cart if there are at least as many items as the coupon requires
      if sale_count <= item_count
        new_cart[item_w_coupon] = {price: sale_price, clearance: item_clear, count: coupon_count}
        new_cart[item] = {price: item_price, clearance: item_clear, count: remaining_items}
        coupon_counter[item] += 1
      end
    else
      #if no applicable coupons return the origional cart
      new_cart
    end
  end
  #return result
  new_cart
end


def apply_clearance(cart)
  new_cart = {}
  cart.each do |item, info_h|
    new_cart[item] = info_h
    if info_h[:clearance] == true
      new_cart[item][:price] = (new_cart[item][:price] * 0.8).round(2)
    end
  end
  new_cart
end

def checkout(cart, coupons)
  consolidated_cart = consolidate_cart(cart)
  coupon_cart = apply_coupons(consolidated_cart, coupons)
  clearance_cart = apply_clearance(coupon_cart)
  #add up prices
  items = clearance_cart.keys
  prices = items.collect do |item|
    clearance_cart[item][:price] * clearance_cart[item][:count]
  end
  subtotal = 0
  prices.each do |i|
    subtotal += i
  end
  if subtotal > 100
    total = subtotal * 0.9
  else
    subtotal
  end
end
