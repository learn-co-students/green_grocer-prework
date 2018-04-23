def consolidate_cart(cart)
  new_cart = {}

  item_list = []
  cart.each do |item|
    item.each do |key, value|
      item_list << key
    end
  end

  cart.each do |item_hash|
    item_hash.each do |item_name, item_info|
      if new_cart[item_name].nil?
        new_cart[item_name] = item_info.merge(:count => item_list.count(item_name))
      end
    end
  end
  new_cart
end

def apply_coupons(cart, coupons)
  coupon_count = {}
  coupons.each do |coupon|
    item = coupon[:item]
    if coupon_count[item].nil?
      coupon_count[item] = 1
    else
      coupon_count[item] += 1
    end

    if cart.keys.include?(item)
      if cart[item][:count] >= coupon[:num]
        cart[item][:count] -= coupon[:num]
        cart["#{item} W/COUPON"] = {:price => coupon[:cost], :clearance => cart[item][:clearance], :count => coupon_count[item]}
      end
    end
  end
  cart
end

def apply_clearance(cart)
  cart.each do |item, info|
    if cart[item][:clearance] == true
      cart[item][:price] -= cart[item][:price]* 0.2
    end
  end
  cart
end

def checkout(cart, coupons)
  final_cart = consolidate_cart(cart)
  apply_coupons(final_cart, coupons)
  apply_clearance(final_cart)

  final_cart.each do |item, info|
    if final_cart[item][:count] == 0
      final_cart.delete(item)
    end
  end

  total = 0
  final_cart.each do |item, info|
    total += final_cart[item][:price] * final_cart[item][:count]
  end

  if total > 100
    total -= total * 0.1
  end
  total
end
