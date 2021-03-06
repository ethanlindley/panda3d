/**
 * PANDA 3D SOFTWARE
 * Copyright (c) Carnegie Mellon University.  All rights reserved.
 *
 * All use of this software is subject to the terms of the revised BSD
 * license.  You should have received a copy of this license along
 * with this source code in a file named "LICENSE."
 *
 * @file pointLight.I
 * @author mike
 * @date 1999-02-04
 */

/**
 *
 */
INLINE PointLight::CData::
CData() :
  _specular_color(1.0f, 1.0f, 1.0f, 1.0f),
  _attenuation(1.0f, 0.0f, 0.0f),
  _max_distance(make_inf((PN_stdfloat)0)),
  _point(0.0f, 0.0f, 0.0f)
{
}

/**
 *
 */
INLINE PointLight::CData::
CData(const PointLight::CData &copy) :
  _specular_color(copy._specular_color),
  _attenuation(copy._attenuation),
  _max_distance(copy._max_distance),
  _point(copy._point)
{
}

/**
 * Returns the color of specular highlights generated by the light.  This is
 * usually the same as get_color().
 */
INLINE const LColor &PointLight::
get_specular_color() const {
  if (_has_specular_color) {
    CDReader cdata(_cycler);
    return cdata->_specular_color;
  } else {
    return get_color();
  }
}

/**
 * Sets the color of specular highlights generated by the light.
 */
INLINE void PointLight::
set_specular_color(const LColor &color) {
  CDWriter cdata(_cycler);
  _has_specular_color = true;
  cdata->_specular_color = color;
}

/**
 * Clears a custom specular color setting, meaning that the specular color
 * will now come from the color.
 */
INLINE void PointLight::
clear_specular_color() {
  _has_specular_color = false;
}

/**
 * Returns the terms of the attenuation equation for the light.  These are, in
 * order, the constant, linear, and quadratic terms based on the distance from
 * the point to the vertex.
 */
INLINE const LVecBase3 &PointLight::
get_attenuation() const {
  CDReader cdata(_cycler);
  return cdata->_attenuation;
}

/**
 * Sets the terms of the attenuation equation for the light.  These are, in
 * order, the constant, linear, and quadratic terms based on the distance from
 * the point to the vertex.
 */
INLINE void PointLight::
set_attenuation(const LVecBase3 &attenuation) {
  CDWriter cdata(_cycler);
  cdata->_attenuation = attenuation;
}

/**
 * Returns the maximum distance at which the light has any effect, as previously
 * specified by set_max_distance.
 */
INLINE PN_stdfloat PointLight::
get_max_distance() const {
  CDReader cdata(_cycler);
  return cdata->_max_distance;
}

/**
 * Sets the radius of the light's sphere of influence.  Beyond this distance, the
 * light may be attenuated to zero, if this is supported by the shader.
 */
INLINE void PointLight::
set_max_distance(PN_stdfloat max_distance) {
  CDWriter cdata(_cycler);
  cdata->_max_distance = max_distance;
}

/**
 * Returns the point in space at which the light is located.  This is local to
 * the coordinate space in which the light is assigned, and is usually 0.
 */
INLINE const LPoint3 &PointLight::
get_point() const {
  CDReader cdata(_cycler);
  return cdata->_point;
}

/**
 * Sets the point in space at which the light is located.  Usually 0.
 */
INLINE void PointLight::
set_point(const LPoint3 &point) {
  CDWriter cdata(_cycler);
  cdata->_point = point;
  mark_viz_stale();
}
