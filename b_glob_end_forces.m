function f = b_glob_end_forces(start_location, load_type, magnitude, direction, load_length, member_length)

load_len = load_length;
length = member_length;
mag = magnitude;

f = zeros(6,1);
end_location = start_location + load_len;
a = start_location + load_len / 2;
b = length - a;

if strcmpi(direction, 'Y')
    
    if strcmpi(load_type, 'point_load')
        
        if a ~= 0 && a ~= length
            
            f(1,1) = 0;
            f(2,1) = mag*b^2*(3*a+b)/length^3;
            f(3,1) = mag*a*b^2/length^2;
            f(4,1) = 0;
            f(5,1) = mag * a^2 * (a+3*b)/length^3;
            f(6,1) = -mag*a^2*b/length^2;
            
        elseif a == length
            
            f(1,1) = 0;
            f(2,1) = 0;
            f(3,1) = 0;
            f(4,1) = 0;
            f(5,1) = mag;
            f(6,1) = 0;
            
        elseif a == 0
            
            f(1,1) = 0;
            f(2,1) = mag;
            f(3,1) = 0;
            f(4,1) = 0;
            f(5,1) = 0;
            f(6,1) = 0;
        end
        
    elseif strcmpi(load_type, 'distributed_load')
        
        if start_location ~= 0 || end_location ~= length
            
            f(1,1) = 0;
            f(2,1) = (mag * load_len/length^3) * ((2*a+length)*b^2+(a-b)/4*load_len^2);
            f(3,1) = (mag * load_len/length^2)*(a*b^2 + ((a - 2*b)*load_len^2)/12);
            f(4,1) = 0;
            f(5,1) = (mag * load_len/length^3) * ((2*b+length)*a^2-(a-b)/4*load_len^2);
            f(6,1) = -(mag * load_len/length^2)*(a^2*b + ((b - 2*a)*load_len^2)/12);
            
        elseif start_locaion == 0 && end_location == 0
            
            f(1,1) = 0;
            f(2,1) = mag*length/2;
            f(3,1) = mag * length^2/12;
            f(4,1) = 0;
            f(5,1) = mag*length/2;
            f(6,1) = -mag * length^2/12;
            
            
        end
        
    end
    
elseif strcmpi(direction, 'X')
    
    if strcmpi(load_type, 'point_load')
        
        if a ~= 0 && a ~= length
            
            f(1,1) = mag * b^2 * (3*a+b)/length^3;
            f(2,1) = 0;
            f(3,1) = mag*a*b^2/length^2;
            f(4,1) = mag*a^2*(a+3*b)/length^3;
            f(5,1) = 0;
            f(6,1) = -mag*a^2*b/length^2;
            
        elseif a == length
            
            f(1,1) = 0;
            f(2,1) = 0;
            f(3,1) = 0;
            f(4,1) = mag;
            f(5,1) = 0;
            f(6,1) = 0;
            
        elseif a == 0
            
            f(1,1) = mag;
            f(2,1) = 0;
            f(3,1) = 0;
            f(4,1) = 0;
            f(5,1) = 0;
            f(6,1) = 0;
        end
        
    elseif strcmpi(load_type, 'distributed_load')
        
        if start_location ~= 0 || end_location ~= length
            
            f(1,1) = (mag * load_len/length^3) * ((2*a+length)*b^2+(a-b)/4*load_len^2);
            f(2,1) = 0;
            f(3,1) = (mag * load_len/length^2)*(a*b^2 + ((a - 2*b)*load_len^2)/12);
            f(4,1) = (mag * load_len/length^3) * ((2*b+length)*a^2-(a-b)/4*load_len^2);
            f(5,1) = 0;
            f(6,1) = -(mag * load_len/length^2)*(a^2*b + ((b - 2*a)*load_len^2)/12);
            
        elseif start_locaion == 0 && end_location == 0
            
            f(1,1) = mag*length/2;
            f(2,1) = 0;
            f(3,1) = mag * length^2/12;
            f(4,1) = mag*length/2;
            f(5,1) = 0;
            f(6,1) = -mag * length^2/12;
            
        end
    end
elseif strcmpi(direction, 'R')
    
        if a ~= 0 && a ~= length
            
            f(1,1) = 0;
            f(2,1) = 6*mag*a*b/length^3;
            f(3,1) = mag*b*(2*a-b)/length^2;
            f(4,1) = 0;
            f(5,1) = -6*mag*a*b/length^3;
            f(6,1) = mag*a*(2*b-a)/length^2;
            
        elseif a == length
            
            f(1,1) = 0;
            f(2,1) = 0;
            f(3,1) = 0;
            f(4,1) = 0;
            f(5,1) = 0;
            f(6,1) = mag;
            
        elseif a == 0
            
            f(1,1) = mag;
            f(2,1) = 0;
            f(3,1) = 0;
            f(4,1) = 0;
            f(5,1) = 0;
            f(6,1) = 0;
        end
        
end

