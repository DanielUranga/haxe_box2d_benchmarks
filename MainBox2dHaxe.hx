package;

import box2D.collision.shapes.B2EdgeShape;
import box2D.collision.shapes.B2PolygonShape;
import box2D.common.math.B2Vec2;
import box2D.dynamics.B2BodyDef;
import box2D.dynamics.B2BodyType;
import box2D.dynamics.B2World;
import haxe.Timer;

class MainBox2dHaxe {

	static var frames = 10;

	public static function main () {
		var gravity = B2Vec2.make(0.0, -10.0);
		var world = new B2World(gravity, false);

		var bd = new B2BodyDef();
		var ground = world.createBody(bd);

		var v1 = B2Vec2.make(-40.0, 0.0);
		var v2 = B2Vec2.make(40.0, 0.0);
		var shape = new B2EdgeShape(v1, v2);

		ground.createFixture2(shape, 0.0);

		var shape = new B2PolygonShape();
		shape.setAsBox(0.5, 0.5);
		var x = B2Vec2.make(-7.0, 0.75);
		var y = B2Vec2.make(0.0, 0.0);
		var deltaX = B2Vec2.make(0.5625, 1.0);
		var deltaY = B2Vec2.make(1.125, 0.0);
		var eCount = 30;
		for (i in 0...eCount) {
			trace(i);
			y.setV(x);
			for (j in 0...eCount) {
				var bd = new B2BodyDef();
				bd.type = B2BodyType.DYNAMIC_BODY;
				bd.position.setV(y);
				var body = world.createBody(bd);
				body.createFixture2(shape, 5.0);
				y.add(deltaY);
			}
			x.add(deltaX);
		}

		var start = Timer.stamp();
		for (i in 0...frames) {
			world.step(1.0/60.0, 3, 3);
		}
		var end = Timer.stamp();

		trace("Total time: " + (end-start));

	}

}
