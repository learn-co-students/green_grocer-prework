cart = [{
  "AVOCADO" => {:price => 3.0, :clearance => true, :count => 3},
  "KALE"    => {:price => 3.0, :clearance => false, :count => 1}
}]

coupon = [
  {:item => "AVOCADO", :num => 2, :cost => 5.00},
  {:item => "AVOCADO", :num => 2, :cost => 5.00}
]

def consolidate_cart(cart)
  return_hash = {}
  counter = 0
  cart.each do |hash|
    hash.each do |key, values|
      if !return_hash[key]
        counter = 0
      end
      counter += 1
      values[:count] = counter
      return_hash[key] = values
    end
  end
  return_hash
end

def apply_coupons(cart, coupons)
  counter = 1
  coupons.each do |coupon|
    item = coupon[:item]
    num = coupon[:num]
    price = coupon[:cost]

    if cart["#{item} W/COUPON"]
      counter += 1
    end

    if cart[item]
      (cart[item][:count] - num) < 0 ? counter -= 1 : cart[item][:count] -= num

        cart["#{item} W/COUPON"] = {
          :price => price,
          :clearance => cart[item][:clearance],
          :count => counter
        }
    end
  end
  cart
end

def apply_clearance(cart)
  cart.each do |item, values_hash|
    if values_hash[:clearance]
      values_hash[:price] -= values_hash[:price]*0.2
    end
  end
  cart
end

def checkout(cart, coupons)
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart,coupons)
  cart = apply_clearance(cart)
  total_price = 0
  cart.each do |item, values_hash|
    total_price += (values_hash[:price]*values_hash[:count])
  end
  if total_price > 100
    total_price -= total_price*0.1
  end
  total_price
end
