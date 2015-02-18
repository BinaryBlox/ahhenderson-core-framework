//------------------------------------------------------------------------------
//
//   ViziFit, Inc. 
//   Copyright 2012 
//   All rights reserved. 
//
//------------------------------------------------------------------------------

package ahhenderson.core.util {
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	
	import mx.graphics.ImageSnapshot;
	import mx.graphics.codec.IImageEncoder;

	public class ImageUtil {

		private static var _bitmapData:BitmapData;

		private static var _imageEncoder:IImageEncoder;

		private static var _imageSnapShot:ImageSnapshot;

		private static var _jpegQuality:Number;

		private static var _matrix:Matrix;

	/*	public static function copyAsBitmapData(sprite:starling.display.DisplayObject, x:Number, y:Number, width:Number, height:Number):BitmapData {
			if (sprite == null)
				return null;
			var resultRect:Rectangle=new Rectangle();
			sprite.getBounds(sprite, resultRect);
			var context:Context3D=Starling.context;
			var support:RenderSupport=new RenderSupport();
			RenderSupport.clear();
			support.setOrthographicProjection(x, y, width, height);
			support.transformMatrix(sprite.root);
			support.translateMatrix(-resultRect.x, -resultRect.y);
			var result:BitmapData=new BitmapData(resultRect.width, resultRect.height, true, 0x00000000);
			support.pushMatrix();
			support.transformMatrix(sprite);
			sprite.render(support, 1.0);
			support.popMatrix();
			support.finishQuadBatch();
			context.drawToBitmapData(result);
			return result;
		}
*/

		public static function scaleBitmap(source:BitmapData, scaleFactor:Number=1, transparent:Boolean=true, smoothing:Boolean=true):BitmapData {

			const targetWidth:Number=source.width * scaleFactor;
			const targetHeight:Number=source.height * scaleFactor;

			// Target bitmap data.
			_bitmapData=new BitmapData(targetWidth, targetHeight, true, 0xffffff)

			// Create scale parameters 
			if (!_matrix)
				_matrix=new Matrix(1, 0, 0, 1, 0, 0);
			else
				_matrix.identity(); // = new Matrix(1, 0, 0, 1, 0, 0);

			// Create scaled bitmap
			_bitmapData.draw(source, _matrix, null, null, null, smoothing);

			return _bitmapData;
		}

		/*function crop( _x:Number, _y:Number, _width:Number, _height:Number, displayObject:DisplayObject = null):Bitmap
		{
			var cropArea:Rectangle = new Rectangle( 0, 0, _width, _height );
			var croppedBitmap:Bitmap = new Bitmap( new BitmapData( _width, _height ), PixelSnapping.ALWAYS, true );
			croppedBitmap.bitmapData.draw( (displayObject!=null) ? displayObject : stage, new Matrix(1, 0, 0, 1, -_x, -_y) , null, null, cropArea, true );
			return croppedBitmap;
		}*/

		public static function scaleBitmapToRectangle(source:BitmapData, rect:Rectangle, crop:Boolean=true, transparent:Boolean=false, color:uint=0x000000, smoothing:Boolean=true):BitmapData {

			if (!rect)
				return null;

			var adjWidthScale:Number=1;
			var adjHeightScale:Number=1;
			var scaleFactor:Number;
			var length:Number;

			if (source.width > rect.width)
				adjWidthScale=rect.width / source.width;

			if (source.height > rect.height)
				adjHeightScale=rect.height / source.height;

			// default to equal scale
			scaleFactor=adjHeightScale;
			length=source.height * adjHeightScale;

			// Set optimal scale
			if (adjWidthScale != adjHeightScale)
				scaleFactor=(adjWidthScale > adjHeightScale) ? adjWidthScale : adjHeightScale;

			// Target bitmap data.
			_bitmapData=new BitmapData(rect.width, rect.height, transparent, color)

			// Create scale parameters 
			if (!_matrix)
				_matrix=new Matrix(1, 0, 0, 1, 0, 0);
			else
				_matrix.identity(); // = new Matrix(1, 0, 0, 1, 0, 0);

			_matrix.scale(scaleFactor, scaleFactor);

			// Create scaled bitmap
			_bitmapData.draw(source, _matrix, null, null, rect, smoothing);

			return _bitmapData;
		}
	}
}
