#include "backend.h"

#include <algorithm>

Backend::Backend(QObject *parent)
    : QObject(parent),
      m_windowTitle(QStringLiteral("Qt Quick Controls Material")),
      m_buttonLabel(QStringLiteral("Raised Button")),
      m_sliderValue(50), m_featureEnabled(true), m_comboIndex(0),
      m_inputText(QString()) {
  updateStatusText();
}

QString Backend::windowTitle() const { return m_windowTitle; }

QString Backend::statusText() const { return m_statusText; }

QString Backend::buttonLabel() const { return m_buttonLabel; }

int Backend::sliderValue() const { return m_sliderValue; }

bool Backend::featureEnabled() const { return m_featureEnabled; }

int Backend::comboIndex() const { return m_comboIndex; }

QString Backend::inputText() const { return m_inputText; }

void Backend::setButtonLabel(const QString &label) {
  if (m_buttonLabel == label) {
    return;
  }
  m_buttonLabel = label;
  emit buttonLabelChanged();
}

void Backend::setSliderValue(int value) {
  value = std::clamp(value, 0, 100);
  if (m_sliderValue == value) {
    return;
  }
  m_sliderValue = value;
  emit sliderValueChanged();
  updateStatusText();
}

void Backend::setFeatureEnabled(bool enabled) {
  if (m_featureEnabled == enabled) {
    return;
  }
  m_featureEnabled = enabled;
  emit featureEnabledChanged();
  updateStatusText();
}

void Backend::setComboIndex(int index) {
  if (m_comboIndex == index) {
    return;
  }
  m_comboIndex = index;
  emit comboIndexChanged();
  updateStatusText();
}

void Backend::setInputText(const QString &text) {
  if (m_inputText == text) {
    return;
  }
  m_inputText = text;
  emit inputTextChanged();
  updateStatusText();
}

void Backend::handleButtonClicked() { setFeatureEnabled(!m_featureEnabled); }

void Backend::updateStatusText() {
  const QString newText =
      QStringLiteral("Value: %1 | %2 | Choice #%3 | Text: %4")
          .arg(m_sliderValue)
          .arg(m_featureEnabled ? QStringLiteral("Enabled")
                                : QStringLiteral("Disabled"))
          .arg(m_comboIndex + 1)
          .arg(m_inputText.isEmpty() ? QStringLiteral("<empty>")
                                     : m_inputText);

  if (m_statusText == newText) {
    return;
  }

  m_statusText = newText;
  emit statusTextChanged();
}
