def consolidate_cart(cart)
  consol = {}
  uniq = cart.uniq
  uniq.each do |hash|
    count = 0
    while cart.include?(hash)
      i = cart.index(hash)
      cart.delete_at(i)
      count += 1
    end
    hash.each {|k, v| consol[k] = v.merge({count: count})}
  end
  consol
end

def apply_coupons(cart, coupons)
  coupons.each do |hash|
    item = hash[:item]
    if cart.include?(item) && cart[item][:count] >= hash[:num]
      item_q = cart[item][:count]
      cpn_q = hash[:num]
      cart[item + " W/COUPON"] = {price: hash[:cost], clearance: cart[item][:clearance], count: item_q / cpn_q}
      cart[item][:count] = item_q % cpn_q
    end
  end
  cart
end

def apply_clearance(cart)
  cart.each do |item, desc|
    if desc[:clearance]
      desc[:price] = (desc[:price] * 0.8).round(2)
    end
  end
  cart
end

def checkout(cart, coupons)
  dc_cart = apply_clearance(apply_coupons(consolidate_cart(cart), coupons))
  dc_cart = extra_ten(dc_cart) if total(dc_cart) > 100
  total(dc_cart)
end

def extra_ten(cart)
  cart.each do |item, desc|
    desc[:price] = (desc[:price] * 0.9).round(2)
  end
  cart
end

def total(cart)
  cart.map {|item, desc| desc[:price] * desc[:count]}.reduce(:+)
end
