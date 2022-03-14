import 'package:json_annotation/json_annotation.dart';

import '../decoder.dart';
import 'entity_property.dart';

import "../keywords.dart" as kw;

part "navigation_property.g.dart";

@JsonSerializable(anyMap: true)
class NavigationProperty extends EntityProperty {
  /// A navigation property of an entity type MAY specify a partner navigation property. Navigation properties of complex types MUST NOT specify a partner.
  ///
  /// If specified, the partner navigation property is identified by a path relative to the entity type specified as the type of the navigation property. This path MUST lead to a navigation property defined on that type or a derived type. The path MAY traverse complex types, including derived complex types, but MUST NOT traverse any navigation properties. The type of the partner navigation property MUST be the declaring entity type of the current navigation property or one of its parent entity types.
  ///
  /// If the partner navigation property is single-valued, it MUST lead back to the source entity from all related entities. If the partner navigation property is collection-valued, the source entity MUST be part of that collection.
  ///
  /// If no partner navigation property is specified, no assumptions can be made as to whether one of the navigation properties on the target type will lead back to the source entity.
  ///
  /// If a partner navigation property is specified, this partner navigation property MUST either specify the current navigation property as its partner to define a bi-directional relationship or it MUST NOT specify a partner navigation property. The latter can occur if the partner navigation property is defined on a complex type, or if the current navigation property is defined on a type derived from the type of the partner navigation property.
  late final dynamic partner;

  /// A navigation property MAY indicate that instances of its declaring structured type contain the targets of the navigation property, in which case the navigation property is called a containment navigation property.
  ///
  /// Containment navigation properties define an implicit entity set for each instance of its declaring structured type. This implicit entity set is identified by the read URL of the navigation property for that structured type instance.
  ///
  /// Instances of the structured type that declares the navigation property, either directly or indirectly via a property of complex type, contain the entities referenced by the containment navigation property. The canonical URL for contained entities is the canonical URL of the containing instance, followed by the path segment of the navigation property and the key of the contained entity, see [OData‑URL].
  ///
  /// Entity types used in collection-valued containment navigation properties MUST have a key defined.
  ///
  /// For items of an ordered collection of complex types (those annotated with the Core.Ordered term defined in [OData-VocCore]), the canonical URL of the item is the canonical URL of the collection appended with a segment containing the zero-based ordinal of the item. Items within in an unordered collection of complex types do not have a canonical URL. Services that support unordered collections of complex types declaring a containment navigation property, either directly or indirectly via a property of complex type, MUST specify the URL for the navigation link within a payload representing that item, according to format-specific rules.
  ///
  /// OData 4.0 responses MUST NOT specify a complex type declaring a containment navigation property as the type of a collection-valued property.
  ///
  /// An entity cannot be referenced by more than one containment relationship, and cannot both belong to an entity set declared within the entity container and be referenced by a containment relationship.
  ///
  /// Containment navigation properties MUST NOT be specified as the last path segment in the path of a navigation property binding.
  ///
  /// When a containment navigation property navigates between entity types in the same inheritance hierarchy, the containment is called recursive.
  ///
  /// Containment navigation properties MAY specify a partner navigation property. If the containment is recursive, the relationship defines a tree, thus the partner navigation property MUST be nullable (for the root of the tree) and single-valued (for the parent of a non-root entity). If the containment is not recursive, the partner navigation property MUST NOT be nullable.
  ///
  /// An entity type inheritance chain MUST NOT contain more than one navigation property with a partner navigation property that is a containment navigation property.
  ///
  /// Note: without a partner navigation property, there is no reliable way for a client to determine which entity contains a given contained entity. This may lead to problems for clients if the contained entity can also be reached via a non-containment navigation path.
  late final bool containsTarget;

  /// A single-valued navigation property MAY define one or more referential constraints. A referential constraint asserts that the dependent property (the property defined on the structured type declaring the navigation property) MUST have the same value as the principal property (the referenced property declared on the entity type that is the target of the navigation).
  ///
  /// The type of the dependent property MUST match the type of the principal property, or both types MUST be complex types.
  ///
  /// If the principle property references an entity, then the dependent property must reference the same entity.
  ///
  /// If the principle property’s value is a complex type instance, then the dependent property’s value must be a complex type instance with the same properties, each with the same values.
  ///
  /// If the navigation property on which the referential constraint is defined is nullable, or the principal property is nullable, then the dependent property MUST also be nullable. If both the navigation property and the principal property are not nullable, then the dependent property MUST NOT be nullable.
  late final dynamic referentialConstraint;

  NavigationProperty(String name, JSON json) : super(name, json) {
    partner = json[kw.partner];
    containsTarget = json[kw.containsTarget] ?? false;
    referentialConstraint = json[kw.referentialConstraint];
  }
}
