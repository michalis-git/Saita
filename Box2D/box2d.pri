# Box2D sources
INCLUDEPATH += $$PWD

HEADERS += \
        $$PWD/Box2D.h \
        $$PWD/Collision/b2BroadPhase.h \
        $$PWD/Collision/b2Collision.h \
        $$PWD/Collision/b2Distance.h \
        $$PWD/Collision/b2DynamicTree.h \
        $$PWD/Collision/b2TimeOfImpact.h \
        $$PWD/Collision/Shapes/b2CircleShape.h \
        $$PWD/Collision/Shapes/b2PolygonShape.h \
        $$PWD/Collision/Shapes/b2Shape.h \
        $$PWD/Common/b2BlockAllocator.h \
        $$PWD/Common/b2Math.h \
        $$PWD/Common/b2Settings.h \
        $$PWD/Common/b2StackAllocator.h \
        $$PWD/Dynamics/b2Body.h \
        $$PWD/Dynamics/b2ContactManager.h \
        $$PWD/Dynamics/b2Fixture.h \
        $$PWD/Dynamics/b2Island.h \
        $$PWD/Dynamics/b2TimeStep.h \
        $$PWD/Dynamics/b2WorldCallbacks.h \
        $$PWD/Dynamics/b2World.h \
        $$PWD/Dynamics/Contacts/b2CircleContact.h \
        $$PWD/Dynamics/Contacts/b2Contact.h \
        $$PWD/Dynamics/Contacts/b2ContactSolver.h \
        $$PWD/Dynamics/Contacts/b2PolygonAndCircleContact.h \
        $$PWD/Dynamics/Contacts/b2PolygonContact.h \
        $$PWD/Dynamics/Contacts/b2TOISolver.h \
        $$PWD/Dynamics/Joints/b2DistanceJoint.h \
        $$PWD/Dynamics/Joints/b2FrictionJoint.h \
        $$PWD/Dynamics/Joints/b2GearJoint.h \
        $$PWD/Dynamics/Joints/b2Joint.h \
        $$PWD/Dynamics/Joints/b2LineJoint.h \
        $$PWD/Dynamics/Joints/b2MouseJoint.h \
        $$PWD/Dynamics/Joints/b2PrismaticJoint.h \
        $$PWD/Dynamics/Joints/b2PulleyJoint.h \
        $$PWD/Dynamics/Joints/b2RevoluteJoint.h \
        $$PWD/Dynamics/Joints/b2WeldJoint.h

SOURCES += \
        $$PWD/Collision/b2BroadPhase.cpp \
        $$PWD/Collision/b2CollideCircle.cpp \
        $$PWD/Collision/b2CollidePolygon.cpp \
        $$PWD/Collision/b2Collision.cpp \
        $$PWD/Collision/b2Distance.cpp \
        $$PWD/Collision/b2DynamicTree.cpp \
        $$PWD/Collision/b2TimeOfImpact.cpp \
        $$PWD/Collision/Shapes/b2CircleShape.cpp \
        $$PWD/Collision/Shapes/b2PolygonShape.cpp \
        $$PWD/Common/b2BlockAllocator.cpp \
        $$PWD/Common/b2Math.cpp \
        $$PWD/Common/b2Settings.cpp \
        $$PWD/Common/b2StackAllocator.cpp \
        $$PWD/Dynamics/b2Body.cpp \
        $$PWD/Dynamics/b2ContactManager.cpp \
        $$PWD/Dynamics/b2Fixture.cpp \
        $$PWD/Dynamics/b2Island.cpp \
        $$PWD/Dynamics/b2WorldCallbacks.cpp \
        $$PWD/Dynamics/b2World.cpp \
        $$PWD/Dynamics/Contacts/b2CircleContact.cpp \
        $$PWD/Dynamics/Contacts/b2Contact.cpp \
        $$PWD/Dynamics/Contacts/b2ContactSolver.cpp \
        $$PWD/Dynamics/Contacts/b2PolygonAndCircleContact.cpp \
        $$PWD/Dynamics/Contacts/b2PolygonContact.cpp \
        $$PWD/Dynamics/Contacts/b2TOISolver.cpp \
        $$PWD/Dynamics/Joints/b2DistanceJoint.cpp \
        $$PWD/Dynamics/Joints/b2FrictionJoint.cpp \
        $$PWD/Dynamics/Joints/b2GearJoint.cpp \
        $$PWD/Dynamics/Joints/b2Joint.cpp \
        $$PWD/Dynamics/Joints/b2LineJoint.cpp \
        $$PWD/Dynamics/Joints/b2MouseJoint.cpp \
        $$PWD/Dynamics/Joints/b2PrismaticJoint.cpp \
        $$PWD/Dynamics/Joints/b2PulleyJoint.cpp \
        $$PWD/Dynamics/Joints/b2RevoluteJoint.cpp \
        $$PWD/Dynamics/Joints/b2WeldJoint.cpp

