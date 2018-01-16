def consolidate_cart(cart)
  new_cart = {}

  cart.each do |item|
    item.each do |name, info|
      if new_cart[name].nil?
        new_cart[name] = info
        new_cart[name][:count] = 1
      else new_cart.keys.include? name
        new_cart[name][:count] += 1
      end
    end
  end
  new_cart
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    couponitem = coupon[:item]

    if cart.include? couponitem
      if cart[couponitem][:count] >= coupon[:num]
        cart[couponitem][:count] -= coupon[:num]
        if cart["#{couponitem} W/COUPON"].nil?
          cart["#{couponitem} W/COUPON"] = {price: coupon[:cost], clearance: cart[couponitem][:clearance], count: 1}
        else cart.include?("#{couponitem} W/COUPON")
          cart["#{couponitem} W/COUPON"][:count] += 1
        end
      end
    end
  end
  cart
end

def apply_clearance(cart)
  cart.each do |item, info|
    if info[:clearance] == true
      info[:price] = (info[:price] * (0.8)).round(2)
    end
  end
end

def checkout(cart, coupons)
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)
  total = 0

  cart.each do |item, info|
    total += info[:price] * info[:count]
  end

  if total > 100
    total = (total * (0.9)).round(2)
  end
  total
end
