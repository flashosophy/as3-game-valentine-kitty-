package com.vitapoly.valentinekitty.model{

	import citrus.objects.NapePhysicsObject;

	import nape.geom.Vec2;
	import nape.phys.Material;
	import nape.shape.Polygon;

	/**
	 * @author Aymeric
	 * <p>This is a class created by the software <a href="http://www.physicseditor.de/">PhysicsEditor</a></p>
	 * <p>Launch PhysicsEditor, select the CitrusEngine template, upload your png picture, set polygons and export.</p>
	 * <p>Be careful, the anchor point is not the localCOM but object's center!</p>
	 * @param peObject the name of the png file
	 */
    public class PhysicsEditorObjects extends NapePhysicsObject {
		
		[Inspectable(defaultValue="")]
		public var peObject:String = "";

		private var _tab:Array;

		public function PhysicsEditorObjects(name:String, params:Object = null) {

			super(name, params);
		}

		override public function destroy():void {

			super.destroy();
		}

		override public function update(timeDelta:Number):void {

			super.update(timeDelta);
		}

		override protected function createShape():void {

			_createVertices();

			for (var i:uint = 0; i < _tab.length; ++i) {

				var polygonShape:Polygon = new Polygon(_tab[i]);
				_shape = polygonShape;
				_body.shapes.add(_shape);
			}

			_body.translateShapes(Vec2.weak(-_body.bounds.width * 0.5, -_body.bounds.height * 0.5));

			_body.position.x += _body.bounds.width * 0.5;
			_body.position.y += _body.bounds.height * 0.5;
		}

		override protected function createMaterial():void {
			
			_material = new Material(_getElasticity(), _getDynamicFriction(), _getStaticFriction(), _getDensity(), _getRollingFriction());
		}
		
        protected function _createVertices():void {
			
			_tab = [];
			var vertices:Array = [];

			switch (peObject) {
				
				case "boot":
											
			        vertices.push(Vec2.weak(88, 57.5));
					vertices.push(Vec2.weak(98.5, 6));
					vertices.push(Vec2.weak(69, 1));
					vertices.push(Vec2.weak(42, 27));
					vertices.push(Vec2.weak(38, 60));
					
					_tab.push(vertices);
					vertices = [];
											
			        vertices.push(Vec2.weak(4, 56));
					vertices.push(Vec2.weak(38, 60));
					vertices.push(Vec2.weak(42, 27));
					vertices.push(Vec2.weak(3.5, 28));
					
					_tab.push(vertices);
					vertices = [];
											
			        vertices.push(Vec2.weak(42, 10));
					vertices.push(Vec2.weak(42, 27));
					vertices.push(Vec2.weak(69, 1));
					
					_tab.push(vertices);
					
					break;
			
				case "rose":
											
			        vertices.push(Vec2.weak(92, 3.5));
					vertices.push(Vec2.weak(76, 3));
					vertices.push(Vec2.weak(60, 10.5));
					vertices.push(Vec2.weak(63.5, 14));
					vertices.push(Vec2.weak(75, 22.5));
					vertices.push(Vec2.weak(91, 23));
					
					_tab.push(vertices);
					vertices = [];
											
			        vertices.push(Vec2.weak(4, 9));
					vertices.push(Vec2.weak(16, 16));
					vertices.push(Vec2.weak(63.5, 14));
					vertices.push(Vec2.weak(60, 10.5));
					
					_tab.push(vertices);
					
					break;
			
				case "tv":
											
			        vertices.push(Vec2.weak(146, 30));
					vertices.push(Vec2.weak(5, 30));
					vertices.push(Vec2.weak(5, 141));
					vertices.push(Vec2.weak(146, 141));
					
					_tab.push(vertices);
					
					break;
			
				case "bottle":
											
			        vertices.push(Vec2.weak(10, 1));
					vertices.push(Vec2.weak(10, 22));
					vertices.push(Vec2.weak(20, 23));
					vertices.push(Vec2.weak(20, 1));
					
					_tab.push(vertices);
					vertices = [];
											
			        vertices.push(Vec2.weak(10, 22));
					vertices.push(Vec2.weak(2, 33));
					vertices.push(Vec2.weak(2, 97));
					vertices.push(Vec2.weak(28, 97));
					vertices.push(Vec2.weak(28, 33));
					vertices.push(Vec2.weak(20, 23));
					
					_tab.push(vertices);
					
					break;
			
				case "alarm":
											
			        vertices.push(Vec2.weak(11, 55));
					vertices.push(Vec2.weak(37, 55));
					vertices.push(Vec2.weak(49, 34));
					vertices.push(Vec2.weak(43, 13.5));
					vertices.push(Vec2.weak(33, 2));
					vertices.push(Vec2.weak(19, 2));
					vertices.push(Vec2.weak(7, 14.5));
					vertices.push(Vec2.weak(1, 33));
					
					_tab.push(vertices);
					vertices = [];
											
			        vertices.push(Vec2.weak(48, 8.5));
					vertices.push(Vec2.weak(33, 2));
					vertices.push(Vec2.weak(43, 13.5));
					
					_tab.push(vertices);
					vertices = [];
											
			        vertices.push(Vec2.weak(0, 10.5));
					vertices.push(Vec2.weak(7, 14.5));
					vertices.push(Vec2.weak(19, 2));
					
					_tab.push(vertices);
					
					break;
			
				case "plant":
											
			        vertices.push(Vec2.weak(1, 30));
					vertices.push(Vec2.weak(10, 72));
					vertices.push(Vec2.weak(38, 72));
					vertices.push(Vec2.weak(48, 32));
					vertices.push(Vec2.weak(25, 27));
					
					_tab.push(vertices);
					
					break;
			
				case "fryingpan":
											
			        vertices.push(Vec2.weak(2, 11));
					vertices.push(Vec2.weak(16, 29));
					vertices.push(Vec2.weak(73, 29));
					vertices.push(Vec2.weak(85, 17.5));
					vertices.push(Vec2.weak(84, 12));
					vertices.push(Vec2.weak(45, 6));
					
					_tab.push(vertices);
					vertices = [];
											
			        vertices.push(Vec2.weak(84, 12));
					vertices.push(Vec2.weak(85, 17.5));
					vertices.push(Vec2.weak(149, 3.5));
					vertices.push(Vec2.weak(144, -0.5));
					
					_tab.push(vertices);
					
					break;
			
				case "teddy":
											
			        vertices.push(Vec2.weak(82, 5));
					vertices.push(Vec2.weak(15, 4));
					vertices.push(Vec2.weak(20, 34));
					vertices.push(Vec2.weak(78, 37));
					
					_tab.push(vertices);
					vertices = [];
											
			        vertices.push(Vec2.weak(86, 107));
					vertices.push(Vec2.weak(82, 76));
					vertices.push(Vec2.weak(21, 83));
					vertices.push(Vec2.weak(20, 110));
					
					_tab.push(vertices);
					vertices = [];
											
			        vertices.push(Vec2.weak(97, 69));
					vertices.push(Vec2.weak(78, 37));
					vertices.push(Vec2.weak(20, 34));
					vertices.push(Vec2.weak(21, 83));
					vertices.push(Vec2.weak(82, 76));
					
					_tab.push(vertices);
					vertices = [];
											
			        vertices.push(Vec2.weak(3, 73));
					vertices.push(Vec2.weak(21, 83));
					vertices.push(Vec2.weak(20, 34));
					
					_tab.push(vertices);
					
					break;
			
				case "anvil":
											
			        vertices.push(Vec2.weak(4, 5));
					vertices.push(Vec2.weak(66, 38));
					vertices.push(Vec2.weak(121.5, 57));
					vertices.push(Vec2.weak(107, 41));
					vertices.push(Vec2.weak(64, 2));
					
					_tab.push(vertices);
					vertices = [];
											
			        vertices.push(Vec2.weak(50, 57));
					vertices.push(Vec2.weak(121.5, 57));
					vertices.push(Vec2.weak(66, 38));
					
					_tab.push(vertices);
					vertices = [];
											
			        vertices.push(Vec2.weak(148, 9));
					vertices.push(Vec2.weak(148, 2));
					vertices.push(Vec2.weak(64, 2));
					vertices.push(Vec2.weak(108, 17));
					
					_tab.push(vertices);
					vertices = [];
											
			        vertices.push(Vec2.weak(108, 17));
					vertices.push(Vec2.weak(64, 2));
					vertices.push(Vec2.weak(107, 41));
					
					_tab.push(vertices);
					
					break;
			
				case "beachball":
											
			        vertices.push(Vec2.weak(72, 147));
					vertices.push(Vec2.weak(133, 117));
					vertices.push(Vec2.weak(148, 68));
					vertices.push(Vec2.weak(124, 21));
					vertices.push(Vec2.weak(71, 2));
					vertices.push(Vec2.weak(18, 26));
					vertices.push(Vec2.weak(1, 70));
					vertices.push(Vec2.weak(19, 123));
					
					_tab.push(vertices);
					
					break;
			
				case "coconut":
											
			        vertices.push(Vec2.weak(17, 2));
					vertices.push(Vec2.weak(2, 19));
					vertices.push(Vec2.weak(5, 38));
					vertices.push(Vec2.weak(24, 47));
					vertices.push(Vec2.weak(45, 39.5));
					vertices.push(Vec2.weak(49, 22));
					vertices.push(Vec2.weak(41, 7));
					
					_tab.push(vertices);
					
					break;
			
				case "umbrella":
											
			        vertices.push(Vec2.weak(10, 96));
					vertices.push(Vec2.weak(125.5, 120));
					vertices.push(Vec2.weak(135, 121));
					vertices.push(Vec2.weak(234, 89));
					vertices.push(Vec2.weak(220, 31));
					vertices.push(Vec2.weak(130, 2));
					vertices.push(Vec2.weak(25, 32));
					
					_tab.push(vertices);
					vertices = [];
											
			        vertices.push(Vec2.weak(137, 242));
					vertices.push(Vec2.weak(135, 121));
					vertices.push(Vec2.weak(125.5, 120));
					
					_tab.push(vertices);
					
					break;
			
				case "frisbee":
											
			        vertices.push(Vec2.weak(94, 2));
					vertices.push(Vec2.weak(7, 2));
					vertices.push(Vec2.weak(3, 11));
					vertices.push(Vec2.weak(97, 11));
					
					_tab.push(vertices);
					
					break;
			
				case "flipflop":
											
			        vertices.push(Vec2.weak(40, 91));
					vertices.push(Vec2.weak(49.5, 80));
					vertices.push(Vec2.weak(36, 4.5));
					vertices.push(Vec2.weak(-0.5, 14));
					vertices.push(Vec2.weak(22, 87.5));
					
					_tab.push(vertices);
					vertices = [];
											
			        vertices.push(Vec2.weak(17, -0.5));
					vertices.push(Vec2.weak(-0.5, 14));
					vertices.push(Vec2.weak(36, 4.5));
					
					_tab.push(vertices);
					
					break;
			
				case "snorkle":
											
			        vertices.push(Vec2.weak(14, 81));
					vertices.push(Vec2.weak(37, 73.5));
					vertices.push(Vec2.weak(76, 57));
					vertices.push(Vec2.weak(8.5, 48));
					vertices.push(Vec2.weak(3, 64));
					
					_tab.push(vertices);
					vertices = [];
											
			        vertices.push(Vec2.weak(51, 4));
					vertices.push(Vec2.weak(76, 57));
					vertices.push(Vec2.weak(98, 81));
					vertices.push(Vec2.weak(92, 36.5));
					
					_tab.push(vertices);
					vertices = [];
											
			        vertices.push(Vec2.weak(98, 81));
					vertices.push(Vec2.weak(76, 57));
					vertices.push(Vec2.weak(60, 88));
					vertices.push(Vec2.weak(69, 119));
					vertices.push(Vec2.weak(82, 119));
					
					_tab.push(vertices);
					vertices = [];
											
			        vertices.push(Vec2.weak(37, 73.5));
					vertices.push(Vec2.weak(60, 88));
					vertices.push(Vec2.weak(76, 57));
					
					_tab.push(vertices);
					
					break;
			
				case "shovel":
											
			        vertices.push(Vec2.weak(5, 3));
					vertices.push(Vec2.weak(18, 48));
					vertices.push(Vec2.weak(29, 49));
					vertices.push(Vec2.weak(40, 3));
					
					_tab.push(vertices);
					vertices = [];
											
			        vertices.push(Vec2.weak(27, 198));
					vertices.push(Vec2.weak(45, 187));
					vertices.push(Vec2.weak(46, 145));
					vertices.push(Vec2.weak(31, 143));
					vertices.push(Vec2.weak(18, 143));
					vertices.push(Vec2.weak(1, 147));
					vertices.push(Vec2.weak(8, 190));
					
					_tab.push(vertices);
					vertices = [];
											
			        vertices.push(Vec2.weak(18, 48));
					vertices.push(Vec2.weak(18, 143));
					vertices.push(Vec2.weak(31, 143));
					vertices.push(Vec2.weak(29, 49));
					
					_tab.push(vertices);
					
					break;
			
				case "toyboat":
											
			        vertices.push(Vec2.weak(92, 12));
					vertices.push(Vec2.weak(31, 10));
					vertices.push(Vec2.weak(6, 22));
					vertices.push(Vec2.weak(26, 35));
					vertices.push(Vec2.weak(92, 35));
					
					_tab.push(vertices);
					vertices = [];
											
			        vertices.push(Vec2.weak(6, 11));
					vertices.push(Vec2.weak(6, 22));
					vertices.push(Vec2.weak(31, 10));
					
					_tab.push(vertices);
					vertices = [];
											
			        vertices.push(Vec2.weak(42, 1));
					vertices.push(Vec2.weak(31, 10));
					vertices.push(Vec2.weak(71, 11));
					vertices.push(Vec2.weak(61, 2));
					
					_tab.push(vertices);
					
					break;
			
				case "rock":
											
			        vertices.push(Vec2.weak(15, 89.5));
					vertices.push(Vec2.weak(69, 94));
					vertices.push(Vec2.weak(122, 56));
					vertices.push(Vec2.weak(66, 6));
					vertices.push(Vec2.weak(25.5, 2));
					vertices.push(Vec2.weak(6, 26));
					vertices.push(Vec2.weak(2, 48));
					
					_tab.push(vertices);
					vertices = [];
											
			        vertices.push(Vec2.weak(119, 87));
					vertices.push(Vec2.weak(122, 56));
					vertices.push(Vec2.weak(69, 94));
					
					_tab.push(vertices);
					
					break;
			
				case "coin":
											
			        vertices.push(Vec2.weak(3, 5));
					vertices.push(Vec2.weak(3, 26));
					vertices.push(Vec2.weak(28, 26));
					vertices.push(Vec2.weak(28, 5));
					
					_tab.push(vertices);
					
					break;
			
			}
		}

		protected function _getElasticity():Number {

			switch (peObject) {
				
				case "boot":
					return 1;
			
				case "rose":
					return 1;
			
				case "tv":
					return 0;
			
				case "bottle":
					return 1;
			
				case "alarm":
					return 1;
			
				case "plant":
					return 0.2;
			
				case "fryingpan":
					return 1;
			
				case "teddy":
					return 1;
			
				case "anvil":
					return 0;
			
				case "beachball":
					return 1;
			
				case "coconut":
					return 0.2;
			
				case "umbrella":
					return 0;
			
				case "frisbee":
					return 0.2;
			
				case "flipflop":
					return 0.2;
			
				case "snorkle":
					return 0.2;
			
				case "shovel":
					return 0.2;
			
				case "toyboat":
					return 0.2;
			
				case "rock":
					return 0;
			
				case "coin":
					return 0.2;
			
			}

			return 0.2;
		}
		
		protected function _getDynamicFriction():Number {
			
			switch (peObject) {
				
				case "boot":
					return 0.5;
			
				case "rose":
					return 0.2;
			
				case "tv":
					return 2.5;
			
				case "bottle":
					return 0.2;
			
				case "alarm":
					return 0.5;
			
				case "plant":
					return 1;
			
				case "fryingpan":
					return 1;
			
				case "teddy":
					return 0.2;
			
				case "anvil":
					return 10;
			
				case "beachball":
					return 1;
			
				case "coconut":
					return 1;
			
				case "umbrella":
					return 1;
			
				case "frisbee":
					return 1;
			
				case "flipflop":
					return 1;
			
				case "snorkle":
					return 1;
			
				case "shovel":
					return 1;
			
				case "toyboat":
					return 1;
			
				case "rock":
					return 10;
			
				case "coin":
					return 1;
			
			}

			return 1;
		}

		protected function _getStaticFriction():Number {
			
			switch (peObject) {
				
				case "boot":
					return 0.5;
			
				case "rose":
					return 0.2;
			
				case "tv":
					return 2.5;
			
				case "bottle":
					return 0.2;
			
				case "alarm":
					return 0.5;
			
				case "plant":
					return 1;
			
				case "fryingpan":
					return 1;
			
				case "teddy":
					return 0.2;
			
				case "anvil":
					return 10;
			
				case "beachball":
					return 1;
			
				case "coconut":
					return 1;
			
				case "umbrella":
					return 1;
			
				case "frisbee":
					return 1;
			
				case "flipflop":
					return 1;
			
				case "snorkle":
					return 1;
			
				case "shovel":
					return 1;
			
				case "toyboat":
					return 1;
			
				case "rock":
					return 10;
			
				case "coin":
					return 1;
			
			}

			return 1;
		}
		
		protected function _getDensity():Number {
			
			switch (peObject) {
				
				case "boot":
					return 0.5;
			
				case "rose":
					return 0.1;
			
				case "tv":
					return 50;
			
				case "bottle":
					return 0.1;
			
				case "alarm":
					return 0.2;
			
				case "plant":
					return 0.7;
			
				case "fryingpan":
					return 2;
			
				case "teddy":
					return 0.05;
			
				case "anvil":
					return 100;
			
				case "beachball":
					return 0.1;
			
				case "coconut":
					return 0.2;
			
				case "umbrella":
					return 50;
			
				case "frisbee":
					return 0.01;
			
				case "flipflop":
					return 1;
			
				case "snorkle":
					return 1;
			
				case "shovel":
					return 2;
			
				case "toyboat":
					return 1;
			
				case "rock":
					return 100;
			
				case "coin":
					return 1;
			
			}

			return 1;
		}

		protected function _getRollingFriction():Number {
			
			switch (peObject) {
				
				case "boot":
					return 0;
			
				case "rose":
					return 0;
			
				case "tv":
					return 0;
			
				case "bottle":
					return 0;
			
				case "alarm":
					return 0;
			
				case "plant":
					return 0;
			
				case "fryingpan":
					return 0;
			
				case "teddy":
					return 0;
			
				case "anvil":
					return 0;
			
				case "beachball":
					return 0;
			
				case "coconut":
					return 0;
			
				case "umbrella":
					return 0;
			
				case "frisbee":
					return 0;
			
				case "flipflop":
					return 0;
			
				case "snorkle":
					return 0;
			
				case "shovel":
					return 0;
			
				case "toyboat":
					return 0;
			
				case "rock":
					return 0;
			
				case "coin":
					return 0;
			
			}

			return 0;
		}
	}
}
