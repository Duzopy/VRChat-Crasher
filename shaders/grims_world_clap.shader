
Shader "Slipknot/grim/Planet crash"
	{

	Properties{
	//Properties
	}

	SubShader
	{
	cull off

	Pass
	{


	CGPROGRAM
			#pragma vertex V
			#pragma fragment P  
			#pragma target 3.0

	

	//Variables

// Planet Shadertoy. Created by Reinder Nijhoff 2015
// @reindernijhoff
//
// https://www.shadertoy.com/view/4tjGRh
//

//#define HIGH_QUALITY
//#define MED_QUALITY
//#define LOW_QUALITY
#define VERY_LOW_QUALITY

static const float PI = 3.14159265359;
static const float DEG_TO_RAD = (PI / 180.0);
static const float MAX = 10000.0;

static const float EARTH_RADIUS = 1000.;
static const float EARTH_ATMOSPHERE = 5.;
static const float EARTH_CLOUDS = 1.;

static const float RING_INNER_RADIUS = 1500.;
static const float RING_OUTER_RADIUS = 2300.;
static const float RING_HEIGHT = 2.;

#ifdef HIGH_QUALITY
  static  const int   SEA_NUM_STEPS = 7;
 static   const int	TERRAIN_NUM_STEPS = 140;
 static   const int   ASTEROID_NUM_STEPS = 11;
static	const int	ASTEROID_NUM_BOOL_SUB = 7;
  static  const int   RING_VOXEL_STEPS = 25;
   static const float ASTEROID_MAX_DISTANCE = 1.1; 
	static const int   FBM_STEPS = 4;
 static   const int   ATMOSPHERE_NUM_OUT_SCATTER = 5;
  static  const int   ATMOSPHERE_NUM_IN_SCATTER = 7;

    #define DISPLAY_LLAMEL
    #define DISPLAY_CLOUDS
    #define DISPLAY_CLOUDS_DETAIL
    #define DISPLAY_TERRAIN_DETAIL
#endif

#ifdef MED_QUALITY
 static   const int   SEA_NUM_STEPS = 6;
 static   const int	TERRAIN_NUM_STEPS = 100;
 static   const int   ASTEROID_NUM_STEPS = 10;
static	const int	ASTEROID_NUM_BOOL_SUB = 6;
static    const int   RING_VOXEL_STEPS = 24;
static    const float ASTEROID_MAX_DISTANCE = 1.; 
static	const int   FBM_STEPS = 4;
static    const int   ATMOSPHERE_NUM_OUT_SCATTER = 4;
static    const int   ATMOSPHERE_NUM_IN_SCATTER = 6;
    #define DISPLAY_CLOUDS
    #define DISPLAY_TERRAIN_DETAIL
    #define DISPLAY_CLOUDS_DETAIL
#endif

#ifdef LOW_QUALITY
static    const int   SEA_NUM_STEPS = 5;
  static  const int	TERRAIN_NUM_STEPS = 75;
 static   const int   ASTEROID_NUM_STEPS = 9;
static	const int	ASTEROID_NUM_BOOL_SUB = 5;
 static   const int   RING_VOXEL_STEPS = 20;
 static   const float ASTEROID_MAX_DISTANCE = .85; 
static	const int   FBM_STEPS = 3;
  static  const int   ATMOSPHERE_NUM_OUT_SCATTER = 3;
  static  const int   ATMOSPHERE_NUM_IN_SCATTER = 5;
#endif

#ifdef VERY_LOW_QUALITY
 static   const int   SEA_NUM_STEPS = 4;
 static   const int	TERRAIN_NUM_STEPS = 60;
 static   const int   ASTEROID_NUM_STEPS = 7;
static	const int	ASTEROID_NUM_BOOL_SUB = 4;
static    const int   RING_VOXEL_STEPS = 16;
 static   const float ASTEROID_MAX_DISTANCE = .67; 
static	const int   FBM_STEPS = 3;
 static   const int   ATMOSPHERE_NUM_OUT_SCATTER = 2;
static    const int   ATMOSPHERE_NUM_IN_SCATTER = 4;
	#define HIDE_TERRAIN
#endif

static const fixed3  SUN_DIRECTION = fixed3( .940721,  .28221626, .18814417 );
static const fixed3  SUN_COLOR = fixed3(.3, .21, .165);

float time;

//-----------------------------------------------------
// Noise functions
//-----------------------------------------------------

float hash( const in float n ) {
    return frac(sin(n)*43758.5453123);
}
float hash( const in fixed2 p ) {
	float h = dot(p,fixed2(127.1,311.7));	
    return frac(sin(h)*43758.5453123);
}
float hash( const in fixed3 p ) {
	float h = dot(p,fixed3(127.1,311.7,758.5453123));	
    return frac(sin(h)*43758.5453123);
}
fixed3 hash31( const in float p) {
	fixed3 h = fixed3(1275.231,4461.7,7182.423) * p;	
    return frac(sin(h)*43758.543123);
}
fixed3 hash33( const in fixed3 p) {
    return fixed3( hash(p), hash(p.zyx), hash(p.yxz) );
}

float noise( const in  float p ) {    
    float i = floor( p );
    float f = frac( p );	
	float u = f*f*(3.0-2.0*f);
    return -1.0+2.0* lerp( hash( i + 0. ), hash( i + 1. ), u);
}

float noise( const in  fixed2 p ) {    
    fixed2 i = floor( p );
    fixed2 f = frac( p );	
	fixed2 u = f*f*(3.0-2.0*f);
    return -1.0+2.0*lerp( lerp( hash( i + fixed2(0.0,0.0) ), 
                     hash( i + fixed2(1.0,0.0) ), u.x),
                lerp( hash( i + fixed2(0.0,1.0) ), 
                     hash( i + fixed2(1.0,1.0) ), u.x), u.y);
}
float noise( const in  fixed3 x ) {
    fixed3 p = floor(x);
    fixed3 f = frac(x);
    f = f*f*(3.0-2.0*f);
    float n = p.x + p.y*157.0 + 113.0*p.z;
    return lerp(lerp(lerp( hash(n+  0.0), hash(n+  1.0),f.x),
                   lerp( hash(n+157.0), hash(n+158.0),f.x),f.y),
               lerp(lerp( hash(n+113.0), hash(n+114.0),f.x),
                   lerp( hash(n+270.0), hash(n+271.0),f.x),f.y),f.z);
}

float tri( const in fixed2 p ) {
    return 0.5*(cos(6.2831*p.x) + cos(6.2831*p.y));
   
}

const fixed2x2 m2 = fixed2x2( 0.80, -0.60, 0.60, 0.80 );

float fbm( in fixed2 p ) {
    float f = 0.0;
    f += 0.5000*noise( p ); p = mul(m2,p*2.02);
    f += 0.2500*noise( p ); p = mul(m2,p*2.03);
    f += 0.1250*noise( p ); 
    
#ifndef LOW_QUALITY
#ifndef VERY_LOW_QUALITY
    p = m2*p*2.01;
    f += 0.0625*noise( p );
#endif
#endif
    return f/0.9375;
}

float fbm( const in fixed3 p, const in float a, const in float f) {
    float ret = 0.0;    
    float amp = 1.0;
    float frq = 1.0;
    for(int i = 0; i < FBM_STEPS; i++) {
        float n = pow(noise(p * frq),2.0);
        ret += n * amp;
        frq *= f;
        amp *= a * (pow(n,0.2));
    }
    return ret;
}

//-----------------------------------------------------
// Lightning functions
//-----------------------------------------------------

float diffuse( const in fixed3 n, const in fixed3 l) { 
    return clamp(dot(n,l),0.,1.);
}

float specular( const in fixed3 n, const in fixed3 l, const in fixed3 e, const in float s) {    
    float nrm = (s + 8.0) / (3.1415 * 8.0);
    return pow(max(dot(reflect(e,n),l),0.0),s) * nrm;
}

float fresnel( const in fixed3 n, const in fixed3 e, float s ) {
    return pow(clamp(1.-dot(n,e), 0., 1.),s);
}

//-----------------------------------------------------
// Math functions
//-----------------------------------------------------

fixed2 rotate(float angle, fixed2 v) {
    return fixed2(cos(angle) * v.x + sin(angle) * v.y, cos(angle) * v.y - sin(angle) * v.x);
}

float boolSub(float a,float b) { 
    return max(a,-b); 
}
float sphere(fixed3 p,float r) {
	return length(p)-r;
}

//-----------------------------------------------------
// Intersection functions (by iq)
//-----------------------------------------------------

fixed3 nSphere( in fixed3 pos, in fixed4 sph ) {
    return (pos-sph.xyz)/sph.w;
}

float iSphere( in fixed3 ro, in fixed3 rd, in fixed4 sph ) {
	fixed3 oc = ro - sph.xyz;
	float b = dot( oc, rd );
	float c = dot( oc, oc ) - sph.w*sph.w;
	float h = b*b - c;
	if( h<0.0 ) return -1.0;
	return -b - sqrt( h );
}

float iCSphereF( fixed3 p, fixed3 dir, float r ) {
	float b = dot( p, dir );
	float c = dot( p, p ) - r * r;
	float d = b * b - c;
	if ( d < 0.0 ) return -MAX;
	return -b + sqrt( d );
}

fixed2 iCSphere2( fixed3 p, fixed3 dir, float r ) {
	float b = dot( p, dir );
	float c = dot( p, p ) - r * r;
	float d = b * b - c;
	if ( d < 0.0 ) return fixed2( MAX, -MAX );
	d = sqrt( d );
	return fixed2( -b - d, -b + d );
}

fixed3 nPlane( in fixed3 ro, in fixed4 obj ) {
    return obj.xyz;
}

float iPlane( in fixed3 ro, in fixed3 rd, in fixed4 pla ) {
    return (-pla.w - dot(pla.xyz,ro)) / dot( pla.xyz, rd );
}

//-----------------------------------------------------
// Wet stone by TDM
// 
// https://www.shadertoy.com/view/ldSSzV
//-----------------------------------------------------

const float ASTEROID_TRESHOLD 	= 0.001;
const float ASTEROID_EPSILON 	= 1e-6;
const float ASTEROID_DISPLACEMENT = 0.1;
const float ASTEROID_RADIUS = 0.13;

const fixed3  RING_COLOR_1 = fixed3(0.42,0.3,0.2);
const fixed3  RING_COLOR_2 = fixed3(0.41,0.51,0.52);

float asteroidRock( const in fixed3 p, const in fixed3 id ) {  
    float d = sphere(p,ASTEROID_RADIUS);    
    for(int i = 0; i < ASTEROID_NUM_BOOL_SUB; i++) {
        float ii = float(i)+id.x;
        float r = (ASTEROID_RADIUS*2.5) + ASTEROID_RADIUS*hash(ii);
        fixed3 v = normalize(hash31(ii) * 2.0 - 1.0);
    	d = boolSub(d,sphere(p+v*r,r * 0.8));       
    }
    return d;
}

float asteroidMap( const in fixed3 p, const in fixed3 id) {
    float d = asteroidRock(p, id) + noise(p*4.0) * ASTEROID_DISPLACEMENT;
    return d;
}

float asteroidMapDetailed( const in fixed3 p, const in fixed3 id) {
    float d = asteroidRock(p, id) + fbm(p*4.0,0.4,2.96) * ASTEROID_DISPLACEMENT;
    return d;
}

void asteroidTransForm(inout fixed3 ro, const in fixed3 id ) {
    float xyangle = (id.x-.5)*time*2.;
    ro.xy = rotate( xyangle, ro.xy );
    
    float yzangle = (id.y-.5)*time*2.;
    ro.yz = rotate( yzangle, ro.yz );
}

void asteroidUnTransForm(inout fixed3 ro, const in fixed3 id ) {
    float yzangle = (id.y-.5)*time*2.;
    ro.yz = rotate( -yzangle, ro.yz );

    float xyangle = (id.x-.5)*time*2.;
    ro.xy = rotate( -xyangle, ro.xy );  
}

fixed3 asteroidGetNormal(fixed3 p, fixed3 id) {
    asteroidTransForm( p, id );
    
    fixed3 n;
    n.x = asteroidMapDetailed(fixed3(p.x+ASTEROID_EPSILON,p.y,p.z), id);
    n.y = asteroidMapDetailed(fixed3(p.x,p.y+ASTEROID_EPSILON,p.z), id);
    n.z = asteroidMapDetailed(fixed3(p.x,p.y,p.z+ASTEROID_EPSILON), id);
    n = normalize(n-asteroidMapDetailed(p, id));
    
    asteroidUnTransForm( n, id );
    return n;
}

fixed2 asteroidSpheretracing(fixed3 ori, fixed3 dir, fixed3 id) {
    asteroidTransForm( ori, id );
    asteroidTransForm( dir, id );
    
    fixed2 td = fixed2(0,1);
    for(int i = 0; i < ASTEROID_NUM_STEPS && abs(td.y) > ASTEROID_TRESHOLD; i++) {
        td.y = asteroidMap(ori + dir * td.x, id);
        td.x += td.y;
    }
    return td;
}

fixed3 asteroidGetStoneColor(fixed3 p, float c, fixed3 l, fixed3 n, fixed3 e) {
	return lerp( diffuse(n,l)*RING_COLOR_1*SUN_COLOR, SUN_COLOR*specular(n,l,e,3.0), .5*fresnel(n,e,5.));    
}

//-----------------------------------------------------
// Ring (by me ;))
//-----------------------------------------------------

const float RING_DETAIL_DISTANCE = 40.;
const float RING_VOXEL_STEP_SIZE = .03;

fixed3 ringShadowColor( const in fixed3 ro ) {
    if( iSphere( ro, SUN_DIRECTION, fixed4( 0., 0., 0., EARTH_RADIUS ) ) > 0. ) {
        return fixed3(0.,0.,0.);
    }
    return fixed3(1.,1.,1.);
}

bool ringMap( const in fixed3 ro ) {
    return ro.z < RING_HEIGHT/RING_VOXEL_STEP_SIZE && hash(ro)<.5;
}

fixed4 renderRingNear( const in fixed3 ro, const in fixed3 rd ) { 
// find startpoint 
    float d1 = iPlane( ro, rd, fixed4( 0., 0., 1., RING_HEIGHT ) );
    float d2 = iPlane( ro, rd, fixed4( 0., 0., 1., -RING_HEIGHT ) );
    
    float d = min( max(d1,0.), max(d2,0.) );
   
    if( (d1 < 0. && d2 < 0.) || d > ASTEROID_MAX_DISTANCE ) {
        return fixed4( 0.,0.,0.,0. );
    } else {
        fixed3 ros = ro + rd*d;

        // avoid precision problems..
        fixed2 mroxy = fmod(ros.xy, fixed2(10.,10.));
        fixed2 roxy = ros.xy - mroxy;
        ros.xy -= roxy;
        ros /= RING_VOXEL_STEP_SIZE;
        //ros.xy -= fixed2(.013,.112)*time*.5;

        fixed3 pos = floor(ros);
        fixed3 ri = 1.0/rd;
        fixed3 rs = sign(rd);
        fixed3 dis = (pos-ros + 0.5 + rs*0.5) * ri;

        float alpha = 0., dint;
        fixed3 offset = fixed3(0,0,0), id, asteroidro;
        fixed2 asteroid = fixed2(0,0);

        for( int i=0; i<RING_VOXEL_STEPS; i++ ) {
            if( ringMap(pos) ) {
                id = hash33(pos);
                offset = id*(1.-2.*ASTEROID_RADIUS)+ASTEROID_RADIUS;
                dint = iSphere( ros, rd, fixed4(pos+offset, ASTEROID_RADIUS) );

                if( dint > 0. ) {
                    asteroidro = ros+rd*dint-(pos+offset);
                    asteroid = asteroidSpheretracing( asteroidro, rd, id );

                    if( asteroid.y < .1 ) {
                        alpha = 1.;
                        break;	    
                    }
                }

            }
            fixed3 mm = step(dis.xyz, dis.yxy) * step(dis.xyz, dis.zzx);
            dis += mm * rs * ri;
            pos += mm * rs;
        }

        if( alpha > 0. ) {       
            fixed3 intersection = ros + rd*(asteroid.x+dint);
            fixed3 n = asteroidGetNormal( asteroidro + rd*asteroid.x, id );

            fixed3 col = asteroidGetStoneColor(intersection, .1, SUN_DIRECTION, n, rd);

            intersection *= RING_VOXEL_STEP_SIZE;
            intersection.xy += roxy;
          //  col *= ringShadowColor( intersection );

            return fixed4( col, 1.-smoothstep(0.4*ASTEROID_MAX_DISTANCE, 0.5* ASTEROID_MAX_DISTANCE, distance( intersection, ro ) ) );
        } else {
            return fixed4(0.,0.,0.,0.);
        }
    }
}

//-----------------------------------------------------
// Ring (by me ;))
//-----------------------------------------------------

float renderRingFarShadow( const in fixed3 ro, const in fixed3 rd ) {
    // intersect plane
    float d = iPlane( ro, rd, fixed4( 0., 0., 1., 0.) );
    
    if( d > 0. ) {
	    fixed3 intersection = ro + rd*d;
        float l = length(intersection.xy);
        
        if( l > RING_INNER_RADIUS && l < RING_OUTER_RADIUS ) {
            return .5 + .5 * (.2+.8*noise( l*.07 )) * (.5+.5*noise(intersection.xy));
        } else {
            return 0.;
        }
    } else {
	    return 0.;
    }
}

fixed4 renderRingFar( const in fixed3 ro, const in fixed3 rd, inout float maxd ) {
    // intersect plane
    float d = iPlane( ro, rd, fixed4( 0., 0., 1., 0.) );
    
    if( d > 0. && d < maxd ) {
        maxd = d;
	    fixed3 intersection = ro + rd*d;
        float l = length(intersection.xy);
        
        if( l > RING_INNER_RADIUS && l < RING_OUTER_RADIUS ) {
            float dens = .5 + .5 * (.2+.8*noise( l*.07 )) * (.5+.5*noise(intersection.xy));
            fixed3 col = lerp( RING_COLOR_1, RING_COLOR_2, abs( noise(l*0.2) ) ) * abs(dens) * 1.5;
            
            col *= ringShadowColor( intersection );
    		col *= .8+.3*diffuse( fixed3(0,0,1), SUN_DIRECTION );
			col *= SUN_COLOR;
            return fixed4( col, dens );
        } else {
            return fixed4(0.,0.,0.,0.);
        }
    } else {
	    return fixed4(0.,0.,0.,0.);
    }
}

fixed4 renderRing( const in fixed3 ro, const in fixed3 rd, inout float maxd ) {
    fixed4 far = renderRingFar( ro, rd, maxd );
    float l = length( ro.xy );

    if( abs(ro.z) < RING_HEIGHT+RING_DETAIL_DISTANCE 
        && l < RING_OUTER_RADIUS+RING_DETAIL_DISTANCE 
        && l > RING_INNER_RADIUS-RING_DETAIL_DISTANCE ) {
     	
	    float d = iPlane( ro, rd, fixed4( 0., 0., 1., 0.) );
        float detail = lerp( .5 * noise( frac(ro.xy+rd.xy*d) * 92.1)+.25, 1., smoothstep( 0.,RING_DETAIL_DISTANCE, d) );
        far.xyz *= detail;    
    }
    
	// are asteroids neaded ?
    if( abs(ro.z) < RING_HEIGHT+ASTEROID_MAX_DISTANCE 
        && l < RING_OUTER_RADIUS+ASTEROID_MAX_DISTANCE 
        && l > RING_INNER_RADIUS-ASTEROID_MAX_DISTANCE ) {
        
        fixed4 near = renderRingNear( ro, rd );
        far = lerp( far, near, near.w );
        maxd=0.;
    }
            
    return far;
}

//-----------------------------------------------------
// Stars (by me ;))
//-----------------------------------------------------

fixed4 renderStars( const in fixed3 rd ) {
	fixed3 rds = rd;
	fixed3 col = fixed3(0,0,0);
    float v = 1.0/( 2. * ( 1. + rds.z ) );
    
    fixed2 xy = fixed2(rds.y * v, rds.x * v);
    float s = noise(rds*134.);
    
    s += noise(rds*470.);
    s = pow(s,19.0) * 0.00001;
    if (s > 0.5) {
        fixed3 backStars = fixed3(s,s,s)*.5 * fixed3(0.95,0.8,0.9); 
        col += backStars;
    }
	return   fixed4( col, 1 ); 
} 

//-----------------------------------------------------
// Atmospheric Scattering by GLtracy
// 
// https://www.shadertoy.com/view/lslXDr
//-----------------------------------------------------

static const float ATMOSPHERE_K_R = 0.166;
static const float ATMOSPHERE_K_M = 0.0025;
static const float ATMOSPHERE_E = 12.3;
static const fixed3  ATMOSPHERE_C_R = fixed3( 0.3, 0.7, 1.0 );
static const float ATMOSPHERE_G_M = -0.85;

static const float ATMOSPHERE_SCALE_H = 4.0 / ( EARTH_ATMOSPHERE );
static const float ATMOSPHERE_SCALE_L = 1.0 / ( EARTH_ATMOSPHERE );

static const float ATMOSPHERE_FNUM_OUT_SCATTER = float(ATMOSPHERE_NUM_OUT_SCATTER);
static const float ATMOSPHERE_FNUM_IN_SCATTER = float(ATMOSPHERE_NUM_IN_SCATTER);

static const int   ATMOSPHERE_NUM_OUT_SCATTER_LOW = 2;
static const int   ATMOSPHERE_NUM_IN_SCATTER_LOW = 4;
static const float ATMOSPHERE_FNUM_OUT_SCATTER_LOW = float(ATMOSPHERE_NUM_OUT_SCATTER_LOW);
static const float ATMOSPHERE_FNUM_IN_SCATTER_LOW = float(ATMOSPHERE_NUM_IN_SCATTER_LOW);

float atmosphericPhaseMie( float g, float c, float cc ) {
	float gg = g * g;
	float a = ( 1.0 - gg ) * ( 1.0 + cc );
	float b = 1.0 + gg - 2.0 * g * c;
    
	b *= sqrt( b );
	b *= 2.0 + gg;	
	
	return 1.5 * a / b;
}

float atmosphericPhaseReyleigh( float cc ) {
	return 0.75 * ( 1.0 + cc );
}

float atmosphericDensity( fixed3 p ){
	return exp( -( length( p ) - EARTH_RADIUS ) * ATMOSPHERE_SCALE_H );
}

float atmosphericOptic( fixed3 p, fixed3 q ) {
	fixed3 step = ( q - p ) / ATMOSPHERE_FNUM_OUT_SCATTER;
	fixed3 v = p + step * 0.5;
	
	float sum = 0.0;
	for ( int i = 0; i < ATMOSPHERE_NUM_OUT_SCATTER; i++ ) {
		sum += atmosphericDensity( v );
		v += step;
	}
	sum *= length( step ) * ATMOSPHERE_SCALE_L;
	
	return sum;
}

fixed4 atmosphericInScatter( fixed3 o, fixed3 dir, fixed2 e, fixed3 l ) {
	float len = ( e.y - e.x ) / ATMOSPHERE_FNUM_IN_SCATTER;
	fixed3 step = dir * len;
	fixed3 p = o + dir * e.x;
	fixed3 v = p + dir * ( len * 0.5 );

    float sumdensity = 0.;
	fixed3 sum = fixed3( 0.0,0.0,0.0 );

    for ( int i = 0; i < ATMOSPHERE_NUM_IN_SCATTER; i++ ) {
        fixed3 u = v + l * iCSphereF( v, l, EARTH_RADIUS + EARTH_ATMOSPHERE );
		float n = ( atmosphericOptic( p, v ) + atmosphericOptic( v, u ) ) * ( PI * 4.0 );
		float dens = atmosphericDensity( v );
  
	    float m = MAX;
		sum += dens * exp( -n * ( ATMOSPHERE_K_R * ATMOSPHERE_C_R + ATMOSPHERE_K_M ) ) 
    		* (1. - renderRingFarShadow( u, SUN_DIRECTION ) );
 		sumdensity += dens;
        
		v += step;
	}
	sum *= len * ATMOSPHERE_SCALE_L;
	
	float c  = dot( dir, -l );
	float cc = c * c;
	
	return fixed4( sum * ( ATMOSPHERE_K_R * ATMOSPHERE_C_R * atmosphericPhaseReyleigh( cc ) + 
                         ATMOSPHERE_K_M * atmosphericPhaseMie( ATMOSPHERE_G_M, c, cc ) ) * ATMOSPHERE_E, 
                	     clamp(sumdensity * len * ATMOSPHERE_SCALE_L,0.,1.));
}

float atmosphericOpticLow( fixed3 p, fixed3 q ) {
	fixed3 step = ( q - p ) / ATMOSPHERE_FNUM_OUT_SCATTER_LOW;
	fixed3 v = p + step * 0.5;
	
	float sum = 0.0;
	for ( int i = 0; i < ATMOSPHERE_NUM_OUT_SCATTER_LOW; i++ ) {
		sum += atmosphericDensity( v );
		v += step;
	}
	sum *= length( step ) * ATMOSPHERE_SCALE_L;
	
	return sum;
}

fixed3 atmosphericInScatterLow( fixed3 o, fixed3 dir, fixed2 e, fixed3 l ) {
	float len = ( e.y - e.x ) / ATMOSPHERE_FNUM_IN_SCATTER_LOW;
	fixed3 step = dir * len;
	fixed3 p = o + dir * e.x;
	fixed3 v = p + dir * ( len * 0.5 );

	fixed3 sum = fixed3( 0.0 ,0.0,0.0);

    for ( int i = 0; i < ATMOSPHERE_NUM_IN_SCATTER_LOW; i++ ) {
		fixed3 u = v + l * iCSphereF( v, l, EARTH_RADIUS + EARTH_ATMOSPHERE );
		float n = ( atmosphericOpticLow( p, v ) + atmosphericOpticLow( v, u ) ) * ( PI * 4.0 );
	    float m = MAX;
		sum += atmosphericDensity( v ) * exp( -n * ( ATMOSPHERE_K_R * ATMOSPHERE_C_R + ATMOSPHERE_K_M ) );
		v += step;
	}
	sum *= len * ATMOSPHERE_SCALE_L;
	
	float c  = dot( dir, -l );
	float cc = c * c;
	
	return sum * ( ATMOSPHERE_K_R * ATMOSPHERE_C_R * atmosphericPhaseReyleigh( cc ) + 
                   ATMOSPHERE_K_M * atmosphericPhaseMie( ATMOSPHERE_G_M, c, cc ) ) * ATMOSPHERE_E;
}

fixed4 renderAtmospheric( const in fixed3 ro, const in fixed3 rd, inout float d ) {    
    // inside or outside atmosphere?
    fixed2 e = iCSphere2( ro, rd, EARTH_RADIUS + EARTH_ATMOSPHERE );
	fixed2 f = iCSphere2( ro, rd, EARTH_RADIUS );
        
    if( length(ro) <= EARTH_RADIUS + EARTH_ATMOSPHERE ) {
        if( d < e.y ) {
            e.y = d;
        }
		d = e.y;
	    e.x = 0.;
        
	    if ( iSphere( ro, rd, fixed4(0,0,0,EARTH_RADIUS)) > 0. ) {
	        d = iSphere( ro, rd, fixed4(0,0,0,EARTH_RADIUS));
		}
    } else {
    	if(  iSphere( ro, rd, fixed4(0,0,0,EARTH_RADIUS + EARTH_ATMOSPHERE )) < 0. ) return fixed4(0.,0.,0.,0.);
        
        if ( e.x > e.y ) {
        	d = MAX;
			return fixed4(0.,0.,0.,0.);
		}
		d = e.y = min( e.y, f.x );
    }
	return atmosphericInScatter( ro, rd, e, SUN_DIRECTION );
}

fixed3 renderAtmosphericLow( const in fixed3 ro, const in fixed3 rd ) {    
    fixed2 e = iCSphere2( ro, rd, EARTH_RADIUS + EARTH_ATMOSPHERE );
    e.x = 0.;
    return atmosphericInScatterLow( ro, rd, e, SUN_DIRECTION );
}

//-----------------------------------------------------
// Seascape by TDM
// 
// https://www.shadertoy.com/view/Ms2SD1
//-----------------------------------------------------

static const int   SEA_ITER_GEOMETRY = 3;
static const int   SEA_ITER_FRAGMENT = 5;

static const float SEA_EPSILON	= 1e-3;
#define       SEA_EPSILON_NRM	(0.1 / _ScreenParams.x)
static const float SEA_HEIGHT = 0.6;
static const float SEA_CHOPPY = 4.0;
static const float SEA_SPEED = 0.8;
static const float SEA_FREQ = 0.16;
static const fixed3  SEA_BASE = fixed3(0.1,0.19,0.22);
static const fixed3  SEA_WATER_COLOR = fixed3(0.8,0.9,0.6);
float       SEA_TIME;
static const fixed2x2  sea_octave_m = fixed2x2(1.6,1.2,-1.2,1.6);

float seaOctave( in fixed2 uv, const in float choppy) {
    uv += noise(uv);        
    fixed2 wv = 1.0-abs(sin(uv));
    fixed2 swv = abs(cos(uv));    
    wv = lerp(wv,swv,wv);
    return pow(1.0-pow(wv.x * wv.y,0.65),choppy);
}

float seaMap(const in fixed3 p) {
    float freq = SEA_FREQ;
    float amp = SEA_HEIGHT;
    float choppy = SEA_CHOPPY;
    fixed2 uv = p.xz; uv.x *= 0.75;
    
    float d, h = 0.0;    
    for(int i = 0; i < SEA_ITER_GEOMETRY; i++) {        
    	d = seaOctave((uv+SEA_TIME)*freq,choppy);
    	d += seaOctave((uv-SEA_TIME)*freq,choppy);
        h += d * amp;        
    	uv =mul(uv, sea_octave_m); freq *= 1.9; amp *= 0.22;
        choppy = lerp(choppy,1.0,0.2);
    }
    return p.y - h;
}

float seaMapHigh(const in fixed3 p) {
    float freq = SEA_FREQ;
    float amp = SEA_HEIGHT;
    float choppy = SEA_CHOPPY;
    fixed2 uv = p.xz; uv.x *= 0.75;
    
    float d, h = 0.0;    
    for(int i = 0; i < SEA_ITER_FRAGMENT; i++) {        
    	d = seaOctave((uv+SEA_TIME)*freq,choppy);
    	d += seaOctave((uv-SEA_TIME)*freq,choppy);
        h += d * amp;        
    	uv =mul(uv, sea_octave_m); freq *= 1.9; amp *= 0.22;
        choppy = lerp(choppy,1.0,0.2);
    }
    return p.y - h;
}

fixed3 seaGetColor( const in fixed3 n, fixed3 eye, const in fixed3 l, const in float att, 
                  const in fixed3 sunc, const in fixed3 upc, const in fixed3 reflected) {  
    fixed3 refraced = SEA_BASE * upc + diffuse(n,l) * SEA_WATER_COLOR * 0.12 * sunc; 
    fixed3 color = lerp(refraced,reflected,fresnel(n, -eye, 3.)*.65 );
    
    color += upc*SEA_WATER_COLOR * (att * 0.18);
    color += sunc * fixed3(specular(n,l,eye,60.0),specular(n,l,eye,60.0),specular(n,l,eye,60.0));
    
    return color;
}

fixed3 seaGetNormal(const in fixed3 p, const in float eps) {
    fixed3 n;
    n.y = seaMapHigh(p);    
    n.x = seaMapHigh(fixed3(p.x+eps,p.y,p.z)) - n.y;
    n.z = seaMapHigh(fixed3(p.x,p.y,p.z+eps)) - n.y;
    n.y = eps;
    return normalize(n);
}

float seaHeightMapTracing(const in fixed3 ori, const in fixed3 dir, out fixed3 p) {  
    float tm = 0.0;
    float tx = 1000.0;    
    float hx = seaMap(ori + dir * tx);
    if(hx > 0.0) return tx;   
    float hm = seaMap(ori + dir * tm);    
    float tmid = 0.0;
    for(int i = 0; i < SEA_NUM_STEPS; i++) {
        tmid = lerp(tm,tx, hm/(hm-hx));                   
        p = ori + dir * tmid;                   
    	float hmid = seaMap(p);
		if(hmid < 0.0) {
        	tx = tmid;
            hx = hmid;
        } else {
            tm = tmid;
            hm = hmid;
        }
    }
    return tmid;
}

fixed3 seaTransform( in fixed3 x ) {
    x.yz = rotate( 0.8, x.yz );
    return x;
}

fixed3 seaUntransform( in fixed3 x ) {
    x.yz = rotate( -0.8, x.yz );
    return x;
}

void renderSea( const in fixed3 ro, const in fixed3 rd, inout fixed3 n, inout float att ) {    
    fixed3 p,
    rom = seaTransform(ro),
    rdm = seaTransform(rd);
    
    rom.y -= EARTH_RADIUS;
    rom *= 1000.;
    rom.xz += fixed2(3.1,.2)*time;

    SEA_TIME = time * SEA_SPEED;
    
    seaHeightMapTracing(rom,rdm,p);
    float squareddist = dot(p - rom, p-rom );
    n = seaGetNormal(p, squareddist * SEA_EPSILON_NRM );
    
    n = seaUntransform(n);
    
    att = clamp(SEA_HEIGHT+p.y, 0.,1.);
}

//-----------------------------------------------------
// Terrain based on Elevated and Terrain Tubes by IQ
//
// https://www.shadertoy.com/view/MdX3Rr
// https://www.shadertoy.com/view/4sjXzG
//-----------------------------------------------------

#ifndef HIDE_TERRAIN

static const mat2 terrainM2 = mat2(1.6,-1.2,1.2,1.6);

float terrainLow( fixed2 p ) {
    p *= 0.0013;

    float s = 1.0;
	float t = 0.0;
	for( int i=0; i<2; i++ ) {
        t += s*tri( p );
		s *= 0.5 + 0.1*t;
        p = 0.97*terrainM2*p + (t-0.5)*0.12;
	}
	return t*33.0;
}

float terrainMed( fixed2 p ) {
    p *= 0.0013;

    float s = 1.0;
	float t = 0.0;
	for( int i=0; i<6; i++ ) {
        t += s*tri( p );
		s *= 0.5 + 0.1*t;
        p = 0.97*terrainM2*p + (t-0.5)*0.12;
	}
            
    return t*33.0;
}

float terrainHigh( fixed2 p ) {
    fixed2 q = p;
    p *= 0.0013;

    float s = 1.0;
	float t = 0.0;
	for( int i=0; i<7; i++ ) {
        t += s*tri( p );
		s *= 0.5 + 0.1*t;
        p = 0.97*terrainM2*p + (t-0.5)*0.12;
	}
    
    t += t*0.015*fbm( q );
	return t*33.0;
}

float terrainMap( const in fixed3 pos ) {
	return pos.y - terrainMed(pos.xz);  
}

float terrainMapH( const in fixed3 pos ) {
    float y = terrainHigh(pos.xz);
    float h = pos.y - y;
    return h;
}

float terrainIntersect( in fixed3 ro, in fixed3 rd, in float tmin, in float tmax ) {
    float t = tmin;
	for( int i=0; i<TERRAIN_NUM_STEPS; i++ ) {
        fixed3 pos = ro + t*rd;
        float res = terrainMap( pos );
        if( res<(0.001*t) || t>tmax  ) break;
        t += res*.9;
	}

	return t;
}

float terrainCalcShadow(in fixed3 ro, in fixed3 rd ) {
	fixed2  eps = fixed2(150.0,0.0);
    float h1 = terrainMed( ro.xz );
    float h2 = terrainLow( ro.xz );
    
    float d1 = 10.0;
    float d2 = 80.0;
    float d3 = 200.0;
    float s1 = clamp( 1.0*(h1 + rd.y*d1 - terrainMed(ro.xz + d1*rd.xz)), 0.0, 1.0 );
    float s2 = clamp( 0.5*(h1 + rd.y*d2 - terrainMed(ro.xz + d2*rd.xz)), 0.0, 1.0 );
    float s3 = clamp( 0.2*(h2 + rd.y*d3 - terrainLow(ro.xz + d3*rd.xz)), 0.0, 1.0 );

    return min(min(s1,s2),s3);
}
fixed3 terrainCalcNormalHigh( in fixed3 pos, float t ) {
    fixed2 e = fixed2(1.0,-1.0)*0.001*t;

    return normalize( e.xyy*terrainMapH( pos + e.xyy ) + 
					  e.yyx*terrainMapH( pos + e.yyx ) + 
					  e.yxy*terrainMapH( pos + e.yxy ) + 
					  e.xxx*terrainMapH( pos + e.xxx ) );
}

fixed3 terrainCalcNormalMed( in fixed3 pos, float t ) {
	float e = 0.005*t;
    fixed2  eps = fixed2(e,0.0);
    float h = terrainMed( pos.xz );
    return normalize(fixed3( terrainMed(pos.xz-eps.xy)-h, e, terrainMed(pos.xz-eps.yx)-h ));
}

fixed3 terrainTransform( in fixed3 x ) {
    x.zy = rotate( -.83, x.zy );
    return x;
}

fixed3 terrainUntransform( in fixed3 x ) {
    x.zy = rotate( .83, x.zy );
    return x;
}


float llamelTime;
static const float llamelScale = 5.;

fixed3 llamelPosition() {
    llamelTime = time*2.5;
    fixed2 pos = fixed2( -400., 135.-llamelTime*0.075* llamelScale);
    return fixed3( pos.x, terrainMed( pos ), pos.y );
}

fixed3 terrainShade( const in fixed3 col, const in fixed3 pos, const in fixed3 rd, const in fixed3 n, const in float spec, 
                   const in fixed3 sunc, const in fixed3 upc, const in fixed3 reflc ) {
	fixed3 sunDirection =  terrainTransform(SUN_DIRECTION);
    float dif = diffuse( n, sunDirection );
    float bac = diffuse( n, fixed3(-sunDirection.x, sunDirection.y, -sunDirection.z) );
    float sha = terrainCalcShadow( pos, sunDirection );
    float amb = clamp( n.y,0.0,1.0);
        
    fixed3 lin  = fixed3(0.0);
    lin += 2.*dif*sunc*fixed3( sha, sha*sha*0.1+0.9*sha, sha*sha*0.2+0.8*sha );
    lin += 0.2*amb*upc;
    lin += 0.08*bac*clamp(fixed3(1.)-sunc, fixed3(0.), fixed3(1.));
    return lerp( col*lin*3., reflc, spec*fresnel(n,-terrainTransform(rd),5.0) );
}

fixed3 terrainGetColor( const in fixed3 pos, const in fixed3 rd, const in float t, const in fixed3 sunc, const in fixed3 upc, const in fixed3 reflc ) {
    fixed3 nor = terrainCalcNormalHigh( pos, t );
    fixed3 sor = terrainCalcNormalMed( pos, t );
        
    float spec = 0.005;

#ifdef DISPLAY_TERRAIN_DETAIL
    float no = noise(5.*fbm(1.11*pos.xz));
#else
 static   const float no = 0.;
#endif
    float r = .5+.5*fbm(.95*pos.xz);
	fixed3 col = (r*0.25+0.75)*0.9*lerp( fixed3(0.08,0.07,0.07), fixed3(0.10,0.09,0.08), noise(0.4267*fixed2(pos.x*2.,pos.y*9.8))+.01*no );
    col = lerp( col, 0.20*fixed3(0.45,.30,0.15)*(0.50+0.50*r),smoothstep(0.825,0.925,nor.y+.025*no) );
	col = lerp( col, 0.15*fixed3(0.30,.30,0.10)*(0.25+0.75*r),smoothstep(0.95,1.0,nor.y+.025*no) );
    col *= .88+.12*no;
        
    float s = nor.y + 0.03*pos.y + 0.35*fbm(0.05*pos.xz) - .35;
    float sf = fwidth(s) * 1.5;
    s = smoothstep(0.84-sf, 0.84+sf, s );
    col = lerp( col, 0.29*fixed3(0.62,0.65,0.7), s);
    nor = lerp( nor, sor, 0.7*smoothstep(0.9, 0.95, s ) );
    spec = lerp( spec, 0.45, smoothstep(0.9, 0.95, s ) );

   	col = terrainShade( col, pos, rd, nor, spec, sunc, upc, reflc );

#ifdef DISPLAY_LLAMEL
    col *= clamp( distance(pos.xz, llamelPosition().xz )*0.4, 0.4, 1.);
#endif
    
    return col;
}

fixed3 terrainTransformRo( const in fixed3 ro ) {
    fixed3 rom = terrainTransform(ro);
    rom.y -= EARTH_RADIUS - 100.;
    rom.xz *= 5.;
    rom.xz += fixed2(-170.,50.)+fixed2(-4.,.4)*time;    
    rom.y += (terrainLow( rom.xz ) - 86.)*clamp( 1.-1.*(length(ro)-EARTH_RADIUS), 0., 1.);
    return rom;
}

fixed4 renderTerrain( const in fixed3 ro, const in fixed3 rd, inout fixed3 intersection, inout fixed3 n ) {    
    fixed3 p,
    rom = terrainTransformRo(ro),
    rdm = terrainTransform(rd);
        
    float tmin = 10.0;
    float tmax = 3200.0;
    
    float res = terrainIntersect( rom, rdm, tmin, tmax );
    
    if( res > tmax ) {
        res = -1.;
    } else {
        fixed3 pos =  rom+rdm*res;
        n = terrainCalcNormalMed( pos, res );
        n = terrainUntransform( n );
        
        intersection = ro+rd*res/100.;
    }
    return fixed4(res, rom+rdm*res);
}

#endif

//-----------------------------------------------------
// LLamels by Eiffie
//
// https://www.shadertoy.com/view/ltsGz4
//-----------------------------------------------------
#ifdef DISPLAY_LLAMEL
float llamelMapSMin(const in float a,const in float b,const in float k){
    float h=clamp(0.5+0.5*(b-a)/k,0.0,1.0);return b+h*(a-b-k+k*h);
}

float llamelMapLeg(fixed3 p, fixed3 j0, fixed3 j3, fixed3 l, fixed4 r, fixed3 rt){//z joint with tapered legs
	float lx2z=l.x/(l.x+l.z),h=l.y*lx2z;
	fixed3 u=(j3-j0)*lx2z,q=u*(0.5+0.5*(l.x*l.x-h*h)/dot(u,u));
	q+=sqrt(max(0.0,l.x*l.x-dot(q,q)))*normalize(cross(u,rt));
	fixed3 j1=j0+q,j2=j3-q*(1.0-lx2z)/lx2z;
	u=p-j0;q=j1-j0;
	h=clamp(dot(u,q)/dot(q,q),0.0,1.0);
	float d=length(u-q*h)-r.x-(r.y-r.x)*h;
	u=p-j1;q=j2-j1;
	h=clamp(dot(u,q)/dot(q,q),0.0,1.0);
	d=min(d,length(u-q*h)-r.y-(r.z-r.y)*h);
	u=p-j2;q=j3-j2;
	h=clamp(dot(u,q)/dot(q,q),0.0,1.0);
	return min(d,length(u-q*h)-r.z-(r.w-r.z)*h);
}

float llamelMap(in fixed3 p) {
	static const fixed3 rt=fixed3(0.0,0.0,1.0);	
	p.y += 0.25*llamelScale;
    p.xz -= 0.5*llamelScale;
    p.xz = fixed2(-p.z, p.x);
    fixed3 pori = p;
        
    p /= llamelScale;
    
	fixed2 c=floor(p.xz);
	p.xz=frac(p.xz)-fixed2(0.5);
    p.y -= p.x*.04*llamelScale;
	float sa=sin(c.x*2.0+c.y*4.5+llamelTime*0.05)*0.15;

    float b=0.83-abs(p.z);
	float a=c.x+117.0*c.y+sign(p.x)*1.57+sign(p.z)*1.57+llamelTime,ca=cos(a);
	fixed3 j0=fixed3(sign(p.x)*0.125,ca*0.01,sign(p.z)*0.05),j3=fixed3(j0.x+sin(a)*0.1,max(-0.25+ca*0.1,-0.25),j0.z);
	float dL=llamelMapLeg(p,j0,j3,fixed3(0.08,0.075,0.12),fixed4(0.03,0.02,0.015,0.01),rt*sign(p.x));
	p.y-=0.03;
	float dB=(length(p.xyz*fixed3(1.0,1.75,1.75))-0.14)*0.75;
	a=c.x+117.0*c.y+llamelTime;ca=cos(a);sa*=0.4;
	j0=fixed3(0.125,0.03+abs(ca)*0.03,ca*0.01),j3=fixed3(0.3,0.07+ca*sa,sa);
	float dH=llamelMapLeg(p,j0,j3,fixed3(0.075,0.075,0.06),fixed4(0.03,0.035,0.03,0.01),rt);
	dB=llamelMapSMin(min(dL,dH),dB,clamp(0.04+p.y,0.0,1.0));
	a=max(abs(p.z),p.y)+0.05;
	return max(min(dB,min(a,b)),length(pori.xz-fixed2(0.5)*llamelScale)-.5*llamelScale);
}

fixed3 llamelGetNormal( in fixed3 ro ) {
    fixed2 e = fixed2(1.0,-1.0)*0.001;

    return normalize( e.xyy*llamelMap( ro + e.xyy ) + 
					  e.yyx*llamelMap( ro + e.yyx ) + 
					  e.yxy*llamelMap( ro + e.yxy ) + 
					  e.xxx*llamelMap( ro + e.xxx ) );
}

fixed4 renderLlamel( in fixed3 ro, const in fixed3 rd, const in fixed3 sunc, const in fixed3 upc, const in fixed3 reflc ) {
    ro -= llamelPosition();
	float t=.1*hash(rd.xy),d,dm=10.0,tm;
	for(int i=0;i<36;i++){
		t+=d=llamelMap(ro+rd*t);
		if(d<dm){dm=d;tm=t;}
		if(t>1000.0 || d<0.00001)break;
	}
	dm=max(0.0,dm);
    if( dm < .02 ) {
        fixed3 col = fixed3(0.45,.30,0.15)*.2;
        fixed3 pos = ro + rd*tm;
        fixed3 nor = llamelGetNormal( pos );
        col = terrainShade( col, pos, rd, nor, .01, sunc, upc, reflc );        
        return fixed4(col, clamp( 1.-(dm-0.01)/0.01,0., 1.) );
    }
    
    return fixed4(0.);
}
#endif

//-----------------------------------------------------
// Clouds (by me ;))
//-----------------------------------------------------

fixed4 renderClouds( const in fixed3 ro, const in fixed3 rd, const in float d, const in fixed3 n, const in float land, 
                   const in fixed3 sunColor, const in fixed3 upColor, inout float shadow ) {
	fixed3 intersection = ro+rd*d;
    fixed3 cint = intersection*0.009;
    float rot = -.2*length(cint.xy) + .6*fbm( cint*.4,0.5,2.96 ) + .05*land;

    cint.xy = rotate( rot, cint.xy );

    fixed3 cdetail = fmod(intersection*3.23,fixed3(50.,50.,50.));
    cdetail.xy = rotate( .25*rot, cdetail.xy );

    float clouds = 1.3*(fbm( cint*(1.+.02*noise(intersection)),0.5,2.96)+.4*land-.3);

#ifdef DISPLAY_CLOUDS_DETAIL
    if( d < 200. ) {
        clouds += .3*(fbm(cdetail,0.5,2.96)-.5)*(1.-smoothstep(0.,200.,d));
    }
#endif

    shadow = clamp(1.-clouds, 0., 1.);

    clouds = clamp(clouds, 0., 1.);
    clouds *= clouds;
    clouds *= smoothstep(0.,0.4,d);

    fixed3 clbasecolor = fixed3(1.,1.,1.);
    fixed3 clcol = .1*clbasecolor*sunColor * fixed3(specular(n,SUN_DIRECTION,rd,36.0),specular(n,SUN_DIRECTION,rd,36.0),specular(n,SUN_DIRECTION,rd,36.0));
    clcol += .3*clbasecolor*sunColor;
    clcol += clbasecolor*(diffuse(n,SUN_DIRECTION)*sunColor+upColor);  
    
    return fixed4( clcol, clouds );
}

//-----------------------------------------------------
// Planet (by me ;))
//-----------------------------------------------------

fixed4 renderPlanet( const in fixed3 ro, const in fixed3 rd, const in fixed3 up, inout float maxd ) {
    float d = iSphere( ro, rd, fixed4( 0., 0., 0., EARTH_RADIUS ) );

    fixed3 intersection = ro + rd*d;
    fixed3 n = nSphere( intersection, fixed4( 0., 0., 0., EARTH_RADIUS ) );
    fixed4 res;

#ifndef HIDE_TERRAIN
    bool renderTerrainDetail = length(ro) < EARTH_RADIUS+EARTH_ATMOSPHERE && 
        					   dot( terrainUntransform( fixed3(0.,1.,0.) ), normalize(ro) ) > .9996;
#endif
    bool renderSeaDetail     = d < 1. && dot( seaUntransform( fixed3(0.,1.,0.) ), normalize(ro) ) > .9999; 
    float mixDetailColor = 0.;
        
	if( d < 0. || d > maxd) {
#ifndef HIDE_TERRAIN
        if( renderTerrainDetail ) {
       		intersection = ro;
            n = normalize( ro );
        } else { 	       
	        return fixed4(0);
        }
#else 
      	return fixed4(0.,0.,0.,0.);
#endif
	}
    if( d > 0. ) {
	    maxd = d;
    }
    float att = 0.;
    
    if( dot(n,SUN_DIRECTION) < -0.1 ) return fixed4( 0., 0., 0., 1. );
    
    float dm = MAX, e = 0.;
    fixed3 col, detailCol, nDetail;
    
    // normal and intersection 
#ifndef HIDE_TERRAIN
    if( renderTerrainDetail ) {   
        res = renderTerrain( ro, rd, intersection, nDetail );
        if( res.x < 0. && d < 0. ) {
	        return fixed4(0);
        }
        if( res.x >= 0. ) {
            maxd = pow(res.x/4000.,4.)*50.;
            e = -10.;
        }
        mixDetailColor = 1.-smoothstep(.75, 1., (length(ro)-EARTH_RADIUS) / EARTH_ATMOSPHERE);
        n = normalize( lerp( n, nDetail, mixDetailColor ) );
    } else 
#endif        
    if( renderSeaDetail ) {    
        float attsea, mf = smoothstep(.5,1.,d);

        renderSea( ro, rd, nDetail, attsea );

        n = normalize(lerp( nDetail, n, mf ));
        att = lerp( attsea, att, mf );
    } else {
        e = fbm( .003*intersection+fixed3(1.,1.,1.),0.4,2.96) + smoothstep(.85,.95, abs(intersection.z/EARTH_RADIUS));
#ifndef HIDE_TERRAIN
        if( d < 1500. ) {
            e += (-.03+.06* fbm( intersection*0.1,0.4,2.96))*(1.-d/1500.);
        }
#endif  
    }
    
    fixed3 sunColor = .25*renderAtmosphericLow( intersection, SUN_DIRECTION).xyz;  
    fixed3 upColor = 2.*renderAtmosphericLow( intersection, n).xyz;  
    fixed3 reflColor = renderAtmosphericLow( intersection, reflect(rd,n)).xyz; 
                 
    // color  
#ifndef HIDE_TERRAIN
    if(renderTerrainDetail ) {
        detailCol = col =  terrainGetColor(res.yzw, rd, res.x, sunColor, upColor, reflColor);
		d = 0.;
    }   
#endif
     
    if( mixDetailColor < 1. ) {
        if( e < .45 ) {
            // sea
            col = seaGetColor(n,rd,SUN_DIRECTION, att, sunColor, upColor, reflColor);    
        } else {
            // planet (land) far
            float land1 = max(0.1, fbm( intersection*0.0013,0.4,2.96) );
            float land2 = max(0.1, fbm( intersection*0.0063,0.4,2.96) );
            float iceFactor = abs(pow(intersection.z/EARTH_RADIUS,13.0))*e;

            fixed3 landColor1 = fixed3(0.43,0.65,0.1) * land1;
            fixed3 landColor2 = RING_COLOR_1 * land2;
            fixed3 mixedLand = (landColor1 + landColor2)* 0.5;
            fixed3 finalLand = lerp(mixedLand, fixed3(7.0, 7.0, 7.0) * land1 * 1.5, max(iceFactor+.02*land2-.02, 0.));

            col = (diffuse(n,SUN_DIRECTION)*sunColor+upColor)*finalLand*.75;
#ifdef HIGH_QUALITY
            col *= (.5+.5*fbm( intersection*0.23,0.4,2.96) );
#endif
        }
    }
    
    if( mixDetailColor > 0. ) {
        col = lerp( col, detailCol, mixDetailColor );
    }
        
#ifdef DISPLAY_LLAMEL
    if(renderTerrainDetail ) {
        fixed3 rom = terrainTransformRo(ro),
        rdm = terrainTransform(rd);
        d = iSphere( rom, rdm, fixed4( llamelPosition(), llamelScale*3. ) );
        if( d > 0. ) {
            fixed4 llamel = renderLlamel( rom+rdm*d, rdm, sunColor, upColor, reflColor );
            col = lerp(col, llamel.rgb, llamel.a);
        }
    }
#endif
    
    d = iSphere( ro, rd, fixed4( 0., 0., 0., EARTH_RADIUS+EARTH_CLOUDS ) );
    if( d > 0. ) { 
        float shadow;
		fixed4 clouds = renderClouds( ro, rd, d, n, e, sunColor, upColor, shadow);
        col *= shadow; 
        col = lerp( col, clouds.rgb, clouds.w );
    }
    
    float m = MAX;
    col *= (1. - renderRingFarShadow( ro+rd*d, SUN_DIRECTION ) );

 	return fixed4( col, 1. ); 
}

//-----------------------------------------------------
// Lens flare by musk
//
// https://www.shadertoy.com/view/4sX3Rs
//-----------------------------------------------------

fixed3 lensFlare( const in fixed2 uv, const in fixed2 pos) {
	fixed2 main = uv-pos;
	fixed2 uvd = uv*(length(uv));
	
	float f0 = 1.5/(length(uv-pos)*16.0+1.0);
	
	float f1 = max(0.01-pow(length(uv+1.2*pos),1.9),.0)*7.0;

	float f2 = max(1.0/(1.0+32.0*pow(length(uvd+0.8*pos),2.0)),.0)*00.25;
	float f22 = max(1.0/(1.0+32.0*pow(length(uvd+0.85*pos),2.0)),.0)*00.23;
	float f23 = max(1.0/(1.0+32.0*pow(length(uvd+0.9*pos),2.0)),.0)*00.21;
	
	fixed2 uvx = lerp(uv,uvd,-0.5);
	
	float f4 = max(0.01-pow(length(uvx+0.4*pos),2.4),.0)*6.0;
	float f42 = max(0.01-pow(length(uvx+0.45*pos),2.4),.0)*5.0;
	float f43 = max(0.01-pow(length(uvx+0.5*pos),2.4),.0)*3.0;
	
	fixed3 c = fixed3(.0,.0,.0);
	
	c.r+=f2+f4; c.g+=f22+f42; c.b+=f23+f43;
	c = c*.5 - fixed3(length(uvd)*.05,length(uvd)*.05,length(uvd)*.05);
	c+=fixed3(f0,f0,f0);
	
	return c;
}

//-----------------------------------------------------
// cameraPath
//-----------------------------------------------------

fixed3 pro, pta, pup;
float dro, dta, dup;

void camint( inout fixed3 ret, const in float t, const in float duration, const in fixed3 dest, inout fixed3 prev, inout float prevt ) {
    if( t >= prevt && t <= prevt+duration ) {
    	ret = lerp( prev, dest, smoothstep(prevt, prevt+duration, t) );
    }
    prev = dest;
    prevt += duration;
}

void cameraPath( in float t, out fixed3 ro, out fixed3 ta, out fixed3 up ) {
#ifndef HIDE_TERRAIN
    time = t = mod( t, 92. );
#else
    time = t = fmod( t, 66. );
#endif
    dro = dta = dup = 0.;

    pro = ro = fixed3(900. ,7000. ,1500. );
    pta = ta = fixed3(    0. ,    0. ,   0. );
    pup = up = fixed3(    0. ,    0.4,   1. ); 
   
    camint( ro, t, 5., fixed3(-4300. ,-1000. , 500. ), pro, dro );
    camint( ta, t, 5., fixed3(    0. ,    0. ,   0. ), pta, dta );
    camint( up, t, 7., fixed3(    0. ,    0.1,   1. ), pup, dup ); 
 
    camint( ro, t, 3., fixed3(-1355. , 1795. , 1.2 ), pro, dro );
    camint( ta, t, 1., fixed3(    0. , 300. ,-600. ), pta, dta );
    camint( up, t, 6., fixed3(    0. ,  0.1,    1. ), pup, dup );

    camint( ro, t, 10., fixed3(-1355. , 1795. , 1.2 ), pro, dro );
    camint( ta, t, 14., fixed3(    0. , 100. ,   600. ), pta, dta );
    camint( up, t, 13., fixed3(    0. ,  0.3,    1. ), pup, dup );
    
    fixed3 roe = seaUntransform( fixed3( 0., EARTH_RADIUS+0.004, 0. ) );
    fixed3 upe = seaUntransform( fixed3( 0., 1., 0. ) );
    
    camint( ro, t, 7.,roe, pro, dro );
    camint( ta, t, 7., fixed3( EARTH_RADIUS + 0., EARTH_RADIUS - 500., 500. ), pta, dta );
    camint( up, t, 6., upe, pup, dup );
        
    camint( ro, t, 17.,roe, pro, dro );
    camint( ta, t, 17., fixed3( EARTH_RADIUS + 500., EARTH_RADIUS + 1300., -100. ), pta, dta );
    camint( up, t, 18., fixed3(.0,1.,1.), pup, dup );
    
    camint( ro, t, 11., fixed3(  3102. ,  0. , 1450. ), pro, dro );
    camint( ta, t, 4., fixed3(    0. ,   -100. ,   0. ), pta, dta );
    camint( up, t, 8., fixed3(    0. ,    0.15,   1. ), pup, dup ); 
#ifndef HIDE_TERRAIN    
    roe = terrainUntransform( fixed3( 0., EARTH_RADIUS+0.004, 0. ) );
    upe = terrainUntransform( fixed3( 0., 1., 0. ) );
    
    camint( ro, t, 7., roe, pro, dro );
    camint( ta, t, 12., fixed3( -EARTH_RADIUS, EARTH_RADIUS+200., 100.), pta, dta );
    camint( up, t, 2., upe, pup, dup );
        
    roe = terrainUntransform( fixed3( 0., EARTH_RADIUS+0.001, 0. ) );
    camint( ro, t, 17.,roe, pro, dro );
    camint( ta, t, 18., roe + fixed3( 5000., EARTH_RADIUS-100., -2000.), pta, dta );
    camint( up, t, 18., fixed3(.0,1.,1.), pup, dup );
        
    roe = terrainUntransform( fixed3( 0., EARTH_RADIUS+1.8, 0. ) );
    camint( ro, t, 4.,roe, pro, dro );
    camint( ta, t, 4.5, roe + fixed3( EARTH_RADIUS, EARTH_RADIUS+2000., -30.), pta, dta );
    camint( up, t, 4., fixed3(.0,1.,1.), pup, dup );
#endif    
    camint( ro, t, 10., fixed3(900. ,7000. , 1500. ), pro, dro );
    camint( ta, t, 2., fixed3(    0. ,    0. ,   0. ), pta, dta );
    camint( up, t, 10., fixed3(    0. ,    0.4,   1. ), pup, dup ); 
    
    up = normalize( up );
}

//-----------------------------------------------------
// mainImage
//-----------------------------------------------------

void V(uint i:SV_VertexID,out half4 c:POSITION) {c=half4((i<<1&2)*2-1.,1-2.*(i&2),1,1);}

			void P(half4 u:POSITION,out half4 s:COLOR) 
			{	

	fixed2 uv = u.y / _ScreenParams.y;
    
    fixed2 p = -1.0 + 2.0 * (u.xy) / _ScreenParams.xy;
    p.x *= 1/1;
    
    fixed3 col;
    
// black bands
    fixed2 bandy = fixed2(.1,.9);
    if( uv.y < bandy.x || uv.y > bandy.y ) {
        col = fixed3(0.,0.,0.);
    } else {
        // camera
        fixed3 ro, ta, up;
        cameraPath( _Time.y*.7, ro, ta, up );

        fixed3 ww = normalize( ta - ro );
        fixed3 uu = normalize( cross(ww,up) );
        fixed3 vv = normalize( cross(uu,ww));
        fixed3 rd = normalize( -p.x*uu + p.y*vv + 2.2*ww );

        float maxd = MAX;  
        col = renderStars( rd ).xyz;

        fixed4 planet = renderPlanet( ro, rd, up, maxd );       
        if( planet.w > 0. ) col.xyz = planet.xyz;

        float atmosphered = maxd;
        fixed4 atmosphere = .85*renderAtmospheric( ro, rd, atmosphered );
        col = col * (1.-atmosphere.w ) + atmosphere.xyz; 

        fixed4 ring = renderRing( ro, rd, maxd );
        if( ring.w > 0. && atmosphered < maxd ) {
           ring.xyz = ring.xyz * (1.-atmosphere.w ) + atmosphere.xyz; 
        }
        col = col * (1.-ring.w ) + ring.xyz;

#ifdef DISPLAY_CLOUDS
        float lro = length(ro);
        if( lro < EARTH_RADIUS+EARTH_CLOUDS*1.25 ) {
            fixed3 sunColor = 2.*renderAtmosphericLow( ro, SUN_DIRECTION);  
            fixed3 upColor = 4.*renderAtmosphericLow( ro, fixed3(-SUN_DIRECTION.x, SUN_DIRECTION.y, -SUN_DIRECTION.z));  

            if( lro < EARTH_RADIUS+EARTH_CLOUDS ) {
                // clouds
                float d = iCSphereF( ro, rd, EARTH_RADIUS + EARTH_CLOUDS );
                if( d < maxd ) {
                    float shadow;
                    fixed4 clouds = renderClouds( ro, rd, d, normalize(ro), 0., sunColor, upColor, shadow );
                    clouds.w *= 1.-smoothstep(0.8*EARTH_CLOUDS,EARTH_CLOUDS,lro-EARTH_RADIUS);
                    col = lerp(col, clouds.rgb, clouds.w * (1.-smoothstep( 10., 30., d)) );
                }
            }
            float offset = lro-EARTH_RADIUS-EARTH_CLOUDS;
            col = lerp( col, .5*sunColor, .15*abs(noise(offset*100.))*clamp(1.-4.*abs(offset)/EARTH_CLOUDS, 0., 1.) );
        }
#endif 

        // post processing
        col = pow( clamp(col,0.0,1.0), fixed3(0.4545,0.4545,0.4545) );
        col *= fixed3(1.,0.99,0.95);   
        col = clamp(1.06*col-0.03, 0., 1.);      

        fixed2 sunuv =  2.7*fixed2( dot( SUN_DIRECTION, -uu ), dot( SUN_DIRECTION, vv ) );
        float flare = dot( SUN_DIRECTION, normalize(ta-ro) );
        col += fixed3(1.4,1.2,1.0)*lensFlare(p, sunuv)*clamp( flare+.3, 0., 1.);

        uv.y = (uv.y-bandy.x)*(1./(bandy.y-bandy.x));
        col *= 0.5 + 0.5*pow( 16.0*uv.x*uv.y*(1.0-uv.x)*(1.0-uv.y), 0.1 ); 
    }
     s = fixed4( col ,1.0);
}

	ENDCG
	}
  }
}

