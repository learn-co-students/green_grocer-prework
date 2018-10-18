def consolidate_cart(cart)

  new_cart = {}

  cart.each do |hash|
    hash.each do |item, value|

        new_cart[item] ||= value
        new_cart[item][:count] ||= 0
        new_cart[item][:count] += 1
    end
  end
  new_cart
end

def apply_coupons(cart, coupons)
  #add_coupons = {}
  #cart.each do |fruit, value|
    coupons.each do |coupon|
      item = coupon[:item]

      if cart[item] && cart[item][:count]  >= coupon[:num]
      #  cart[fruit][:count] = cart[fruit][:count] - coupon[:num]

        if cart[item + " W/COUPON"]
          cart[item + " W/COUPON"][:count] += 1

        else
        cart[item + " W/COUPON"] = {:price => coupon[:cost], :count => 1}
        cart[item + " W/COUPON"][:clearance] = cart[item][:clearance]
        #end
      end
      cart[item][:count] -= coupon[:num]
    end
  end
  cart
end

def apply_clearance(cart)

  cart.each do |fruit, value|
    if value[:clearance] == true
      new_price = value[:price] * 0.80
      value[:price] = new_price.round(2)

    else
      value[:price]
    end
  end
end

def checkout(cart, coupons)

  new_cart = consolidate_cart(cart)
  coupon_items = apply_coupons(new_cart, coupons)
  final_cart = apply_clearance(coupon_items)

  amount = 0

  final_cart.each do |fruit, value|
    amount += value[:price] * value[:count]
  end

  amount = amount * 0.9 if amount > 100
  amount

end
