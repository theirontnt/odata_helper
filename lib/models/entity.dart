// ignore_for_file: constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

import '../decoder.dart';
import '../keywords.dart' as kw;
import 'base.dart';
import 'entity_property.dart';

part 'entity.g.dart';

@JsonSerializable(anyMap: true)
class Entity extends Base {
  /// An entity is uniquely identified within an entity set by its key. A key MAY be specified if the entity type does not specify a base type that already has a key declared.
  ///
  /// In order to be specified as the type of an entity set or a collection-valued containment navigation property, the entity type MUST either specify a key or inherit its key from its base type.
  ///
  /// In OData 4.01 responses entity types used for singletons or single-valued navigation properties do not require a key. In OData 4.0 responses entity types used for singletons or single-valued navigation properties MUST have a key defined.
  ///
  /// An entity type (whether or not it is marked as abstract) MAY define a key only if it doesn’t inherit one.
  ///
  /// An entity type’s key refers to the set of properties whose values uniquely identify an instance of the entity type within an entity set. The key MUST consist of at least one property.
  ///
  /// Key properties MUST NOT be nullable and MUST be typed with an enumeration type, one of the following primitive types, or a type definition based on one of these primitive types:
  ///
  /// - Edm.Boolean
  /// - Edm.Byte
  /// - Edm.Date
  /// - Edm.DateTimeOffset
  /// - Edm.Decimal
  /// - Edm.Duration
  /// - Edm.Guid
  /// - Edm.Int16
  /// - Edm.Int32
  /// - Edm.Int64
  /// - Edm.SByte
  /// - Edm.String
  /// - Edm.TimeOfDay
  ///
  /// Key property values MAY be language-dependent, but their values MUST be unique across all languages and the entity ids (defined in [OData‑Protocol]) MUST be language independent.
  ///
  /// A key property MUST be a non-nullable primitive property of the entity type itself, including non-nullable primitive properties of non-nullable single-valued complex properties, recursively.
  ///
  /// In OData 4.01 the key properties of a directly related entity type MAY also be part of the key if the navigation property is single-valued and not nullable. This includes navigation properties of non-nullable single-valued complex properties (recursively) of the entity type. If a key property of a related entity type is part of the key, all key properties of the related entity type MUST also be part of the key.
  ///
  /// If the key property is a property of a complex property (recursively) or of a directly related entity type, the key MUST specify an alias for that property that MUST be a simple identifier and MUST be unique within the set of aliases, structural and navigation properties of the declaring entity type and any of its base types.
  ///
  /// An alias MUST NOT be defined if the key property is a primitive property of the entity type itself.
  ///
  /// For key properties that are a property of a complex or navigation property, the alias MUST be used in the key predicate of URLs instead of the path to the property because the required percent-encoding of the forward slash separating segments of the path to the property would make URL construction and parsing rather complicated. The alias MUST NOT be used in the query part of URLs, where paths to properties don’t require special encoding and are a standard constituent of expressions anyway.
  late final dynamic key;

  /// An entity type MAY indicate that it is open and allows clients to add properties dynamically to instances of the type by specifying uniquely named property values in the payload used to insert or update an instance of the type.
  ///
  /// An entity type derived from an open entity type MUST indicate that it is also open.
  ///
  /// Note: structural and navigation properties MAY be returned by the service on instances of any structured type, whether or not the type is marked as open. Clients MUST always be prepared to deal with additional properties on instances of any structured type, see [OData‑Protocol].
  late final bool openType;

  /// An entity type MAY indicate that it is abstract and cannot have instances.
  ///
  /// For OData 4.0 responses a non-abstract entity type MUST define a key or derive from a base type with a defined key.
  ///
  /// An abstract entity type MUST NOT inherit from a non-abstract entity type.
  late final bool isAbstract;

  /// An entity type that does not specify a base type MAY indicate that it is a media entity type. Media entities are entities that represent a media stream, such as a photo. Use a media entity if the out-of-band stream is the main topic of interest and the media entity is just additional structured information attached to the stream. Use a normal entity with one or more properties of type Edm.Stream if the structured data of the entity is the main topic of interest and the stream data is just additional information attached to the structured data. For more information on media entities see [OData‑Protocol].
  ///
  /// An entity type derived from a media entity type MUST indicate that it is also a media entity type.
  ///
  /// Media entity types MAY specify a list of acceptable media types using an annotation with term Core.AcceptableMediaTypes, see [OData-VocCore].
  late final bool hasStream;

  /// An entity type can inherit from another entity type by specifying it as its base type.
  ///
  /// An entity type inherits the key as well as structural and navigation properties of its base type.
  ///
  /// An entity type MUST NOT introduce an inheritance cycle by specifying a base type.
  late final String? baseType;

  /// Properties of this entity
  final List<EntityProperty> properties = [];

  bool hasProperty(String name) => properties.indexWhere((element) => element.name == name) != -1;

  /// Pass JSON representation of the entity
  ///
  /// [name] is the name of the Entity (or Data Class if you would)
  Entity(String name, JSON json) : super(name, json) {
    // extended classes may have different `$Kind`
    if (runtimeType is Entity && json[kw.kind] != kw.entityKind) {
      throw "Entity must be of ${kw.entityKind} kind";
    }

    openType = json[kw.openType] == true;
    isAbstract = json[kw.isAbstract] == true;
    hasStream = json[kw.hasStream] == true;

    baseType = json[kw.baseType];
    key = json[kw.key];

    for (String key in json.keys) {
      if (!key.startsWith(r"$")) {
        properties.add(EntityProperty(key, json[key]));
      }
    }
  }

  static Entity fromJson(JSON json) => _$EntityFromJson(json);

  JSON toJson() => _$EntityToJson(this);
}
