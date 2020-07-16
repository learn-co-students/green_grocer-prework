def consolidate_cart(cart)
  # code here
 new_hash = {}
 cart.each do |h|
   h.each do |key,value|
     if new_hash[key].nil?
       new_hash[key] = value.merge({:count => 1})
      else 
        new_hash[key][:count] +=1
     end 
   end 
 end 
 new_hash
end

def apply_coupons(cart, coupons)
  # code here
  hash = cart
  
  coupons.each do |ele|
    item = ele[:item]
   if !hash[item].nil? && hash[item][:count] >= ele[:num]
     built_hash = {
       "#{item} W/COUPON" =>{
         :price => ele[:cost],
        :clearance => hash[item][:clearance],
        :count => 1
       }
       
     }
     
     if hash["#{item} W/COUPON"].nil?
        hash.merge!(built_hash)
      else
        hash["#{item} W/COUPON"][:count] += 1
        #hash["#{item} W/COUPON"][:price] += coupon_hash[:cost]
      end
      
      hash[item][:count] -= ele[:num]
   end 
  end 
  hash
end

def apply_clearance(cart)
  # code here
  cart.each do |k,v|
    if v[:clearance] == true
      dis = v[:price] * 0.2
     v[:price] = v[:price] - dis
    end 
  
  
  end 
  cart
end

def checkout(cart, coupons)
  # code here
  a1 = consolidate_cart(cart)
  a2 = apply_coupons(a1,coupons)
  a3 = apply_clearance(a2)
  
  amount = 0 
  
  a3.each do |k, v|
    amount += v[:price] * v[:count]
  end
  
  amount > 100 ? amount * 0.9 : amount
  
end
