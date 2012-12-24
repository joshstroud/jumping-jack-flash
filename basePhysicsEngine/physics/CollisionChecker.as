/*
Collision detection by Frederik Humblet
(c) Boulevart N.V.
http://labs.boulevart.be

Port from the AS2 version by Grant Skinner
http://www.gskinner.com/blog/archives/2005/08/flash_8_shape_b.html
*/
package physics{
	import flash.geom.Rectangle;
	import flash.geom.Point;
	import flash.geom.Matrix;
	import flash.geom.ColorTransform;

	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	import flash.display.BitmapDataChannel;
	import flash.display.BlendMode;
	public class CollisionChecker {
		public function _getCollision(target1:DisplayObject,target2:DisplayObject,tollerance:Number=0):Rectangle {
			var res:Rectangle;
			if (target1.parent==target2.parent) {        						// so display objects need to have the same parent (i.e. the stage or a display container of some kind)
				var par:DisplayObjectContainer=target1.parent;
				var rect1:Rectangle=target1.getBounds(par);
				var rect2:Rectangle=target2.getBounds(par);
				var isIntersecting:Boolean=rect1.intersects(rect2);  			// if isIntersecting is false, then function returns a null rectangle
				if (isIntersecting) {
					var combinedRect:Rectangle=rect1.union(rect2);				// combinedRect is a rectangle which includes in it both rectangles given
					var alpha1:BitmapData=getAlphaMap(target1,combinedRect,BitmapDataChannel.RED,rect1);	// rect1 is in RED
					var alpha2:BitmapData=getAlphaMap(target2,combinedRect,BitmapDataChannel.GREEN,rect2);	// rect2 is in GREEN
					alpha1.draw(alpha2,new Matrix,new ColorTransform(),BlendMode.LIGHTEN);					// so now, alpha1 and alpha two show the outline of the two rects, with their intersection in a 0x010100 color, and the rest in red and green			
					if (tollerance>1) {
						tollerance=1;
					}
					if (tollerance<0) {
						tollerance=0;
					}
					var colorsearch:uint;
					if (tollerance==0) {
						colorsearch=0x010100;
					} else {
						var tollByte:Number=Math.round(tollerance*255);
						colorsearch=(tollByte<<16)|(tollByte<<8)|0;				// basically colorsearch = tollerance* weird calculation (tollerance gets bigger, then 0xRRGG00 gets darker)
																				// I'm pretty sure this just makes colorsearch equal the 
					}
					res=alpha1.getColorBoundsRect(colorsearch,colorsearch);		// this returns a rectangle of where the two objs intersect
					res.x+=combinedRect.x;
					res.y+=combinedRect.y;
					return res;
				}
			}
			return res;
		}
		private function getAlphaMap(target:DisplayObject,rect:Rectangle,channel:uint,myrect:Rectangle):BitmapData {
			var bmd:BitmapData=new BitmapData(rect.width,rect.height,true,0);				// BitmapData of a transparent solid black rectangle
			var m:Matrix=new Matrix();
			var offX:Number=target.x-myrect.x;			// the x of the target dispObject - the x of the leastmost part of the dispObject (think of a circle. The point furthest to the left is myrect.x)
			var offY:Number=target.y-myrect.y;			// same as above but with y
			var xpos:Number=myrect.x+offX-rect.x;		// x of the leastmost part of the dispObject + offX - x of the combined rect of the objs (so basically the left-most point of the two objects combined)
			var ypos:Number=myrect.y+offY-rect.y;		// same as above with y
			m.translate(xpos,ypos);
			bmd.draw(target,m);					// so bmd here now has the bitmap data of a black rectangle, whose coordinates have been shifted so that the x of the 
			var alphachannel:BitmapData=new BitmapData(rect.width,rect.height,false,0);

			alphachannel.copyChannel(bmd,bmd.rect,new Point(0,0),BitmapDataChannel.ALPHA,channel);
			return alphachannel;

		}
		public function _getCollisionPoint(target1:DisplayObject,target2:DisplayObject,tollerance:Number=0):Point {
			var pt:Point;
			var collisionRect:Rectangle=_getCollision(target1,target2,tollerance);
			if (collisionRect!=null && collisionRect.size.length>0) {
				var xcoord:Number=(collisionRect.left+collisionRect.right)/2;
				var ycoord:Number=(collisionRect.top+collisionRect.bottom)/2;
				pt=new Point(xcoord,ycoord);
			}
			return pt;
		}
		public function _isColliding(target1:DisplayObject,target2:DisplayObject,tollerance:Number=0):Boolean {
			var collisionRect:Rectangle=_getCollision(target1,target2,tollerance);
			if (collisionRect!=null && collisionRect.size.length>0) {
				return true;
			} else {
				return false;
			}
		}
	}
}