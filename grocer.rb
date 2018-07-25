def consolidate_cart(cart)
  result={}
  cart.each do |item|
    item.each do |key,value|
       result[key]||= value
       result[key][:count]||=0
       result[key][:count]+=1
    end
  end
  result
end

def apply_coupons(cart, coupons)
   coupons.each do |coupon|
     fruit=coupon[:item]
     name=fruit+" W/COUPON"
     if cart.has_key?(fruit)
         if cart[fruit][:count]>=coupon[:num]
            cart[fruit][:count]-=coupon[:num]
            if cart[name].nil?
                cart[name]={}
                cart[name][:price]=coupon[:cost]
                cart[name][:clearance]=cart[coupon[:item]][:clearance]
                cart[name][:count]=1
            else
                cart[name][:count]+=1
            end
          end
     end
   end
  cart
end

def apply_clearance(cart)
  cart.each do|item,detail|
   if detail[:clearance]==true
     detail[:price]=(detail[:price]*0.8).round(2)
   end
  end
  cart
end

def checkout(cart, coupons)
  cart=consolidate_cart(cart)
  cart=apply_coupons(cart,coupons)
  cart=apply_clearance(cart)
  total=0
     cart.each do |item,detail|
       total+=(detail[:price]*detail[:count])
     end
     if total>100
        total=(total*0.9).round(2)
     end
   total  
end
