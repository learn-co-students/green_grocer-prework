require "pry"


def consolidate_cart(cart)
cart_hash = {}
  cart.each do |list|
    list.each do |item, info|

      if cart_hash[item] == nil
      cart_hash[item] = info
      cart_hash[item][:count] = 1

      else cart_hash[item][:count] +=1

      end
    end
  end
cart_hash
end

def apply_coupons(cart, coupons)
  coupon_hash = {}
  if coupons == nil || coupons.empty?
    return cart
  end

  coupons.each do |coupon|
    cart.each do |item, details|
      coupon_hash[item] = details
      coupon_name = "#{item} W/COUPON"

      if item == coupon[:item]
        coupon_hash[item][:count] = (details[:count] - coupon[:num])

        if coupon_hash.include?(coupon_name)
          coupon_hash[coupon_name][:count]
        else

          coupon_hash[coupon_name] = {:price => coupon[:cost], :clearance =>  details[:clearance], :count => (details[:count] / coupon[:num]) +1 }



end
end
end
  end

  coupon_hash
  # binding.pry
end

def apply_clearance(cart)
  # code here
end

def checkout(cart, coupons)
  # code here
end
coupon = {:item => "AVOCADO", :num => 2, :cost => 5.0}

cart =  {
  "AVOCADO" => {:price => 3.0, :clearance => true, :count => 3},
  "KALE"    => {:price => 3.0, :clearance => false, :count => 1}
}
