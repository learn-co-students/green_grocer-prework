def consolidate_cart(cart)
  # code here
  hash_cart = {}
  cart.each do |hash|
    count = 0
    cart.each do |hash2|
      if hash.keys[0] == hash2.keys[0]
        count += 1
      end
    end
    hash_cart[hash.keys[0]]= hash.values[0]
    hash_cart[hash.keys[0]][:count]= count
  end
  hash_cart
end

def apply_coupons(cart, coupons_arr)
  # code here
  new_cart = cart.clone

  cart.each do |item, attrs|
    count= 0
    coupons_arr.each do |coupon|  
      if coupon[:item] == item && coupon[:num] <= attrs[:count]
        count+= 1
        attrs[:count] = attrs[:count] - coupon[:num]
        new_cart["#{item} W/COUPON"]= {}
        new_cart["#{item} W/COUPON"][:price]= coupon[:cost]
        new_cart["#{item} W/COUPON"][:clearance]= attrs[:clearance]
        new_cart["#{item} W/COUPON"][:count]= count
      end
    end
  end
  new_cart
end

def apply_clearance(cart)
  # code here
  cart.each do |item, attrs|
    if attrs[:clearance] == true
      attrs[:price]*= 0.8
      attrs[:price] =  attrs[:price].round(2)
    end
  end
end

def checkout(cart, coupons)
  # code here
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)
  price = 0
  cart.each do |item, attrs|
    amount = attrs[:price] * attrs[:count]
    price+= amount
  end
  if price > 100
    price*= 0.9
  end
  price
end

cart = [
  {"AVOCADO" => {:price => 3.0, :clearance => true }},
  {"AVOCADO" => {:price => 3.0, :clearance => true }},
  {"KALE"    => {:price => 3.0, :clearance => false}}
]

puts consolidate_cart(cart)